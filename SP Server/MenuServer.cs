using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Runtime.InteropServices.JavaScript;
using System.Text;
using System.Windows.Forms;

namespace SP_Server
{
    public partial class MenuServer : Form
    {
        private bool isSQLConnected = false;
        private string IP = "127.0.0.1";
        private int PORT = 7070;
        //<string, string, IPEndPoint> : <client_id, user_id, hostname> 
        Dictionary<string, UserClient> userClients = new Dictionary<string, UserClient>();
        List<Room> Rooms = new List<Room>();
        public MenuServer()
        {
            InitializeComponent();
        }

        private void MenuServer_Load(object sender, EventArgs e)
        {
            CheckForIllegalCrossThreadCalls = false;
            clearAll();
            loadHost();
            LogMenu logMenu = new LogMenu();
            logMenu.Show();

            writeLog("Connecting to SQL Database");
            new Thread(() => connectSQL()).Start();
            while (!isSQLConnected) { Thread.Sleep(1500); writeLog("Waiting to connect to SQL Database..."); }
            writeLog("Connected to SQL Database, ready to start Server");

            loadData();
        }
        //Kết nối với SQL Database
        private void connectSQL()
        {
            while (true)
            {
                try
                {
                    string query = "SELECT * FROM [User].[Users];";
                    DataTable dt = SqlQuery.getData(query);
                    if (dt.Rows.Count > 0) { isSQLConnected = true; break; }
                }
                catch (Exception ex) { Console.WriteLine("Connecting SQL \r\n" + ex.ToString()); }
            }
        }
        //Reset mọi control trên form
        private void clearAll()
        {
            lbxClients.Items.Clear();
            lvRooms.Items.Clear();
            userClients.Clear();
            Rooms.Clear();
        }
        //Load dữ liệu từ CSDL SQL lên form
        private void loadData()
        {
            showRooms();
        }
        private void startServer()
        {
            using (UdpClient udpClient = new UdpClient(PORT))
            {
                while (true)
                {
                    //Nhận dữ liệu
                    IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, PORT),
                        BroadcastIp = new IPEndPoint(IPAddress.Broadcast, PORT);
                    Byte[] receiveBytes = udpClient.Receive(ref RemoteIpEndPoint);
                    if (receiveBytes.Length == 0) receiveBytes = udpClient.Receive(ref BroadcastIp);
                    string data = Encoding.UTF8.GetString(receiveBytes);
                    //Dữ liệu không đúng định dạng sẽ bỏ qua
                    if (!data.Contains("./")) continue;
                    runCommand(data);
                }
            }
        }
        private void sendData(IPEndPoint host, string data)
        {
            using (UdpClient udpClient = new UdpClient())
            {
                Byte[] sendBytes = Encoding.UTF8.GetBytes(data);
                udpClient.Send(sendBytes, sendBytes.Length, host);
            }
        }
        private void runCommand(string command)
        {
            //Kết nối Server với Client
            if (command.Contains("./connect"))
            {
                //Command:  ./connect <ip>
                //Example: ./connect 192.168.1.100
                string[] cmdsplit = command.Split(" ");
                connectClient(cmdsplit[1]);
                return;
            }
            if (command.Contains("./login"))
            {
                //Command:  ./login <client_id> <username>|<email> <password>
                //Example: ./login 1 tdk@123 XXXXXXX 
                //Example: ./login 1 tester@gm.com XXXXXXX 
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                loginUser(cmdsplit[1], cmdsplit[2], cmdsplit[3]);
                return;
            }
            //Lấy dữ liệu View của Id
            if (command.Contains("./loadview"))
            {
                //Command:  ./loadview <client_id> <view> [<subview_id>]
                //Example: ./loadview 1 000001 rooms 
                //Example: ./loadview 1 000001 roompost 1 
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                if (!userClients.ContainsKey(cmdsplit[1])) { writeLog("Lỗi - Không tìm thấy client có id:" + cmdsplit[1]); return; }
                KeyValuePair<string, UserClient> host =
                    new KeyValuePair<string, UserClient>(cmdsplit[1], userClients[cmdsplit[1]]);
                if (cmdsplit.Length < 4)
                    loadView(host, cmdsplit[2]);
                else
                    loadView(host, cmdsplit[2], cmdsplit[3]);
                return;
            }
            //Quên mật khẩu, lấy mã PIN xác thực
            if (command.Contains("./forgetpass"))
            {
                //Command: ./forgetpass <client_id> <user_id>
                //Example: ./forgetpass 1 000001 
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                forgetPassword(cmdsplit[1], cmdsplit[2]);
                return;
            }
        }

        //Nhận lệnh connect và gửi lại xác nhận.
        private void connectClient(string ip)
        {
            string id = userClients.Count.ToString();
            lbxClients.Items.Add("Client ID: " + id + " (" + ip + ")");
            userClients.Add(id, new UserClient(new IPEndPoint(IPAddress.Parse(ip), PORT)));
            writeLog("Yêu cầu kết nối - " + ip, id);
            sendData(userClients[id].Ip, "[OK] " + ip + " " + id + " " + IP);
            writeLog("Đã kết nối với Client " + id + " - " + userClients[id].Ip.ToString());
        }
        private void loginUser(string client_id, string username, string pass)
        {
            string query = string.Format("SELECT id, password FROM [User].[Users] WHERE username = '{0}' OR email = '{0}';", username);
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không tìm thấy username: " + username); sendData(userClients[client_id].Ip, "[EMPTY]"); return; }

            string id = dt.Rows[0]["id"].ToString();
            string password = dt.Rows[0]["password"].ToString();
            if (pass != password) { writeLog("Mật khẩu không khớp"); sendData(userClients[client_id].Ip, "[WRONG PASS]"); return; }
            userClients[client_id].Id = id;
            writeLog("Đăng nhập thành công UserID: " + id);
            sendData(userClients[client_id].Ip, "[OK] " + getUser(id));
        }
        private string getUser(string id)
        {
            User user = User.loadUser(id);
            string data = string.Empty;
            data += id;
            data += " " + user.Username;
            data += " " + user.Email;
            data += " " + user.Info.Fullname.Replace(" ", "_");
            data += " " + user.Info.Nickname.Replace(" ", "_");
            data += " " + user.Info.Birthdate;
            data += " " + user.Info.Gender;
            return data;
        }
        private void forgetPassword(string client_id, string user_id)
        {
            if (!userClients.ContainsKey(client_id)) { writeLog("Lỗi - Không tìm thấy client có id:" + client_id); return; }
            User user = User.loadUser(user_id);
            string PIN = sendEmailForget(user.Email);
            sendData(userClients[client_id].Ip, "[OK] " + PIN);
        }
        private string sendEmailForget(string email)
        {
            //eojh pefj sann yywt
            string PIN = randomOTP();
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            NetworkCredential credential = new NetworkCredential(
                "sharingplace.mobile@gmail.com", "eojhpefjsannyywt");
            MailMessage message = new MailMessage();
            smtp.Credentials = credential;
            smtp.EnableSsl = true;
            message.From = new MailAddress("sharingplace.mobile@gmail.com", "Sharing Place Support");
            message.To.Add(new MailAddress(email));
            message.Subject = "XÁC THỰC LẤY LẠI MẬT KHẨU";
            message.Body = "Mã xác thực: " + PIN;
            message.IsBodyHtml = true;
            while (true)
            {
                try
                {
                    smtp.Send(message);
                    break;
                }
                catch (Exception ex) { writeLog("Không thể gửi email"); }
            }
            smtp.Dispose();
            return PIN;
        }
        private string randomOTP()
        {
            return new Random().Next(100000, 999999).ToString();
        }
        private void loadView(KeyValuePair<string, UserClient> host, string view, string subview_id = "-1")
        {
            if (view.Contains("rooms")) { loadListRooms(host); return; }
            if (view.Contains("roompost")) { loadListRoomPost(host, subview_id); return; }
            if (view.Contains("roommember")) { loadListRoomPost(host, subview_id); return; }
        }
        private void loadListRooms(KeyValuePair<string, UserClient> host)
        {
            string query = "SELECT id, roomname, type FROM [Rooms].[Rooms], [Rooms].[Members] WHERE id = room_id AND [Rooms].[Members].user_id = " + host.Value.Id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count < 1) { writeLog("[EMPTY]", host.Key); sendData(host.Value.Ip, "[EMPTY]"); return; }
            string data = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                data += dt.Rows[i]["id"] + " ";
                data += dt.Rows[i]["roomname"] + " ";
                data += dt.Rows[i]["type"] + ";";
            }
            writeLog(data, host.Key);
            sendData(host.Value.Ip, data);
        }
        //Load dữ liệu bài viết phòng
        private void loadListRoomPost(KeyValuePair<string, UserClient> host, string room_id)
        {
            if (room_id == "-1") { writeLog("Lỗi - Không tìm thấy room có id: " + room_id); return; }
            string query = "SELECT id, roomname, type FROM [Post].[Posts], [Rooms].[Members] WHERE id = room_id AND [Rooms].[Members].user_id = " + host.Value.Id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count < 1) { writeLog("Không tìm thấy bài viết trong room có id:" + room_id, host.Key); sendData(host.Value.Ip, "[EMPTY]"); return; }
            string data = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                data += dt.Rows[i]["id"].ToString() + " ";
                data += dt.Rows[i]["roomname"].ToString().Replace(" ", "_") + " ";
                data += dt.Rows[i]["type"].ToString() + ";";
            }

            writeLog(data, host.Key);
            sendData(host.Value.Ip, data);
        }
        //Load dữ liệu thành viên phòng
        private void loadListRoomMember(KeyValuePair<string, UserClient> host, string room_id)
        {
            if (room_id == "-1") { writeLog("Lỗi - Không tìm thấy room có id: " + room_id); return; }
            string query = "SELECT id, fullname, nickname FROM [Room].[Members], [User].[Info] WHERE user_id = _id AND room_id = " + room_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count < 1) { writeLog("Không tìm thấy thành viên trong room có id:" + room_id, host.Key); sendData(host.Value.Ip, "[EMPTY]"); return; }
            string data = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                data += dt.Rows[i]["id"].ToString() + " ";
                data += dt.Rows[i]["fullname"].ToString().Replace(" ", "_") + " ";
                data += dt.Rows[i]["nickname"].ToString().Replace(" ", "_") + ";";
            }
            writeLog(data, host.Key);
            sendData(host.Value.Ip, data);
        }
        //Load dữ liệu danh sách thông tin User khi có DataTable
        private Dictionary<string, UserInfo> loadUsersInfo(DataTable dt)
        {
            Dictionary<string, UserInfo> Users = new Dictionary<string, UserInfo>();
            for (int i = 0; i < dt.Rows.Count; i++) Users.Add(dt.Rows[i]["_id"].ToString(), UserInfo.loadUserInfo(dt, i));
            return Users;
        }
        //Load dữ liệu danh sách bài viết khi có DataTable
        private Dictionary<string, Post> loadPosts(DataTable dt)
        {
            Dictionary<string, Post> Posts = new Dictionary<string, Post>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string id = dt.Rows[i]["id"].ToString();
                string owner = dt.Rows[i]["user_id"].ToString();
                string tittle = dt.Rows[i]["title"].ToString();
                string body = dt.Rows[i]["body"].ToString();
                string status = dt.Rows[i]["status"].ToString();
                Post post = new Post(id, tittle, body, status, owner);
                post.Comments = loadComments(id);
                post.Emotions = loadEmotions(id);
                Posts.Add(id, post);
            }
            return Posts;
        }
        //Load dữ liệu emotes khi có id bài viết
        private Dictionary<string, Emotion> loadEmotions(string post_id)
        {
            Dictionary<string, Emotion> emotions = new Dictionary<string, Emotion>();
            string query = "SELECT * FROM [Post].[Emotions] WHERE post_id = " + post_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không có dữ liệu emote của bài viết id: " + post_id); return emotions; }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string id = dt.Rows[i]["user_id"].ToString();
                string type = dt.Rows[i]["type"].ToString();
                Emotion emotion = new Emotion(id, type);
                emotions.Add(id, emotion);
            }
            return emotions;
        }
        //Load dữ liệu comment khi có id bài viết
        private Dictionary<string, Comment> loadComments(string post_id)
        {
            Dictionary<string, Comment> comments = new Dictionary<string, Comment>();
            string query = "SELECT * FROM [Post].[Comments] WHERE post_id = " + post_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không có dữ liệu comment của bài viết id: " + post_id); return comments; }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string user_id = dt.Rows[i]["user_id"].ToString();
                string body = dt.Rows[i]["body"].ToString();
                Comment comment = new Comment(user_id, body);
                comments.Add(user_id, comment);
            }
            return comments;
        }
        //Load dữ liệu phòng
        private void loadRooms()
        {
            string query = "SELECT * FROM [Room].[Rooms];";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không thấy dữ liệu phòng"); return; }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string id = dt.Rows[i]["id"].ToString();
                string name = dt.Rows[i]["roomname"].ToString();
                string type = dt.Rows[i]["type"].ToString();
                string owner = dt.Rows[i]["user_id"].ToString();
                Room room = new Room(id, name, type, owner);
                room.Members = loadRoomMembers(id);
                room.Posts = loadRoomPosts(id);
                Rooms.Add(room);
            }

        }
        //Load dữ liệu thành viên của phòng với id
        private Dictionary<string, UserInfo> loadRoomMembers(string room_id)
        {
            string query = "SELECT [User].[Info].* FROM [Room].[Members], [User].[Info] WHERE user_id = _id AND room_id = " + room_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không thấy dữ liệu thành viên của phòng có id: " + room_id); return new Dictionary<string, UserInfo>(); }
            return loadUsersInfo(dt);
        }
        //Load dữ liệu bài viết của phòng với id
        private Dictionary<string, Post> loadRoomPosts(string room_id)
        {
            string query = "SELECT [PP].* FROM [Room].[Posts], [Post].[Posts] AS [PP] WHERE post_id = id AND room_id = " + room_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không thấy dữ liệu bài viết của phòng có id: " + room_id); return new Dictionary<string, Post>(); }
            return loadPosts(dt);
        }
        //Hiển thị danh sách phòng
        private void showRooms()
        {
            loadRooms();
            lvRooms.Items.Clear();
            foreach (Room room in Rooms)
            {
                ListViewItem lvi = new ListViewItem();
                lvi.Text = room.Name;
                lvi.Tag = room;
                lvi.ToolTipText =
                    "Room ID: " + room.Id + "\r\n" +
                    "Members: " + room.Members.Count + "\r\n" +
                    "Post: " + room.Posts.Count;
                lvRooms.Items.Add(lvi);
            }

        }
        //Viết lịch sử lệnh gửi nhận
        public static void writeLog(string data, string client_id = null)
        {
            if (data.Length > 50) data = data.Substring(0, 50) + "...";
            if (client_id != null)
                LogMenu.rtbxLog.Text += DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " Client " + client_id + ": " + data + "\r\n";
            else
                LogMenu.rtbxLog.Text += DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " Server: " + data + "\r\n";
        }

        private void btnAllClients_Click(object sender, EventArgs e)
        {
            ListAccount la = new ListAccount();
            la.Show();
        }

        private void loadHost()
        {
            tbxIP.Text = IP;
            tbxPort.Text = PORT.ToString();
        }

        private void btnStartServer_Click(object sender, EventArgs e)
        {
            if (!IPAddress.TryParse(tbxIP.Text.Trim(), out var ip)) { writeLog("IP address is wrong format."); return; }
            if (!int.TryParse(tbxPort.Text.Trim(), out var port)) { writeLog("Port is wrong format."); return; }
            IP = tbxIP.Text.Trim();
            PORT = int.Parse(tbxPort.Text.Trim());
            writeLog("Starting Server from " + IP + ":" + PORT);
            new Thread(() => startServer()).Start();
        }

        private void MenuServer_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && e.Shift && e.KeyCode == Keys.H)
            {
                LogMenu logMenu = new LogMenu();
                logMenu.Show();
            }
        }

        private void MenuServer_FormClosing(object sender, FormClosingEventArgs e)
        {
            Environment.Exit(0);
        }
    }
}
