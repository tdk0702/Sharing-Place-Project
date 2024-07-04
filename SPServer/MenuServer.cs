using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Data.SqlClient;
using System.Runtime.InteropServices.JavaScript;
using System.Text;
using System.Windows.Forms;
using System.Xml.Linq;
using System.Reflection;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

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
            while (!isSQLConnected)
            {
                Thread.Sleep(1500);
                writeLog("Waiting to connect to SQL Database...");
            }
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
                    string query = "SELECT 1;";
                    SqlQuery.testConnection();
                    SqlQuery.getData(query);
                    isSQLConnected = true; break;
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

            if (command.Contains("./register"))
            {
                //Command:  ./register <client_id> <username> <email> <password> <fullname>
                //Example: ./register 1 tdk@123 tester@gm.com XXXXXXX Tester_User
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                regUser(cmdsplit[1], cmdsplit[2], cmdsplit[3], cmdsplit[4], cmdsplit[5]);
                return;
            }
            //Lấy dữ liệu View của Id
            if (command.Contains("./loadview"))
            {
                //Command:  ./loadview <client_id> <view> [<subview_id>]
                //Example: ./loadview 1 rooms 
                //Example: ./loadview 1 roompost 1 
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
                //Command: ./forgetpass <client_id> <username>|<email>
                //Example: ./forgetpass 1 tdk0702 
                //Example: ./forgetpass 1 tester@gm.com 
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                forgetPassword(cmdsplit[1], cmdsplit[2]);
                return;
            }
            //Đặt lại mật khẩu
            if (command.Contains("./renewpass"))
            {
                //Command: ./renewpass <client_id> <user_id> <password>
                //Example: ./renewpass 1 001 XXXXXX 
                string[] cmdsplit = command.Split(" ");
                writeLog(command, cmdsplit[1]);
                renewPassword(cmdsplit[1], cmdsplit[2], cmdsplit[3]);
                return;
            }
	    if (command.Contains("./message"))
            {
                string[] cmdsplit = command.Split(" ");
                string senderId = cmdsplit[1];
                string receiverId = cmdsplit[2];
                string message = string.Join(" ", cmdsplit, 3, cmdsplit.Length - 3);
                saveMessageToDatabase(senderId, receiverId, message);
                forwardMessage(receiverId, message);
                return;
            }
            if (command.Contains("./emotion"))
            {
                string[] cmdsplit = command.Split(" ");
                string senderId = cmdsplit[1];
                string messageId = cmdsplit[2];
                string emotion = cmdsplit[3];
                saveEmotionToDatabase(senderId, messageId, emotion);
                forwardEmotion(senderId, messageId, emotion);
                return;
            }
            if (command.StartsWith("./file"))
            {
                handleFileTransfer(command);
                return;
            }
            if (command.Contains("./voice"))
            {
                string[] cmdsplit = command.Split(" ");
                string senderId = cmdsplit[1];
                string receiverId = cmdsplit[2];
                string audioBase64 = cmdsplit[3];
                saveVoiceMessageToDatabase(senderId, receiverId, audioBase64);
                forwardVoiceMessage(receiverId, audioBase64);
                return;
            }
            if (command.Contains("./groupmessage"))
            {
                string[] cmdsplit = command.Split(" ");
                string senderId = cmdsplit[1];
                string roomId = cmdsplit[2];
                string message = string.Join(" ", cmdsplit, 3, cmdsplit.Length - 3);
                saveGroupMessageToDatabase(senderId, roomId, message);
                forwardGroupMessage(roomId, senderId, message);
                return;
            }
            if (command.Contains("./runquery"))
            {
                //Command: ./runquery <client_id> <query>
                //Example: ./runquery 1 SELECT Id,name,fullname [User].[Users] WHERE ...
                //Bỏ ./runquery
                string query = command.Substring(command.IndexOf(" ") + 1);
                string id = query.Substring(0,command.IndexOf(" "));
                query = query.Substring(command.IndexOf(" ") + 1);
                //Lấy selected items: id, name, fullname 
                string[] items = command.Substring(command.IndexOf(" ") + 1, command.IndexOf("]") - 1).Split(",");
                runQuery(userClients[id], query, items);
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
            if (!Hasher.Verify(pass, password)) { writeLog("Mật khẩu không khớp"); sendData(userClients[client_id].Ip, "[WRONG PASS]"); return; }
            userClients[client_id].Id = id;
            writeLog("Đăng nhập thành công UserID: " + id);
            sendData(userClients[client_id].Ip, "[OK] " + getUser(id));
        }
        private void regUser(string client_id, string username, string email, string pass, string name)
        {
            name = name.Replace("_", " ");
            string query = string.Format("SELECT id FROM [User].[Users] WHERE username = '{0}' OR email = '{1}';", username, email);
            DataTable dt = SqlQuery.getData(query); 
            if (dt.Rows.Count > 0) { writeLog("Đã tồn tại tài khoản id: " + dt.Rows[0]["id"].ToString()); sendData(userClients[client_id].Ip, "[EXIST]"); return; }
            query = string.Format("INSERT INTO [User].[Users] VALUES (N'{0}', N'{1}', N'{2}', DEFAULT);", username, pass, email);
            SqlQuery.queryData(query);
            query = "SELECT id FROM [User].[Users] WHERE username = '" + username +"';";
            dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Lỗi không đăng ký được."); sendData(userClients[client_id].Ip, "[ERROR]"); return; }
            string id = dt.Rows[0]["id"].ToString();
            query = string.Format("INSERT INTO [User].[Info] VALUES({0}, N'{1}', NULL, NULL, DEFAULT, NULL, DEFAULT);", id, name);
            writeLog("Đăng ký thành công UserID: " + id);
            sendData(userClients[client_id].Ip, "[OK] " + id);
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
        private void forgetPassword(string client_id, string username)
        {
            if (!userClients.ContainsKey(client_id)) { writeLog("Lỗi - Không tìm thấy client có id:" + client_id); return; }
            string query = string.Format("SELECT id,username,email FROM [User].[Users] WHERE username = '{0}' OR email = '{0}';", username);
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không tồn tại tài khoản: " + username); sendData(userClients[client_id].Ip, "[EXIST]"); return; }
            string email;
            string id = dt.Rows[0]["id"].ToString();
            if (!(username.Contains("@") && username.Contains(".")))
            {
                email = dt.Rows[0]["email"].ToString();
            }
            else email = username;
            string PIN = sendEmailForget(email);
            writeLog("Đã gửi mail, mã PIN: " + PIN);
            sendData(userClients[client_id].Ip, string.Join(" ","[OK]",id,PIN));
        }
        private string sendEmailForget(string email)
        {
            //skad yybw ohhd sfml
            string PIN = randomOTP();
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            NetworkCredential credential = new NetworkCredential(
                "sharingplace.mobile@gmail.com", "skadyybwohhdsfml");
            MailMessage message = new MailMessage();
            smtp.Credentials = credential;
            smtp.EnableSsl = true;
            message.From = new MailAddress("sharingplace.mobile@gmail.com", "Sharing Place Support");
            message.To.Add(new MailAddress(email));
            message.Subject = "XÁC THỰC LẤY LẠI MẬT KHẨU";
            message.Body = "Mã xác thực: " + PIN;
            message.IsBodyHtml = true;
            int TTL = 3;
            while (TTL>0)
            {
                try
                {
                    TTL--;
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

        private void renewPassword(string client_id, string user_id ,string password)
        {
            if (!userClients.ContainsKey(client_id)) { writeLog("Lỗi - Không tìm thấy client có id:" + client_id); return; }
            string query = string.Format("SELECT id FROM [User].[Users] WHERE id = {0} ;", user_id);
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không tồn tại tài khoản id: " + user_id); sendData(userClients[client_id].Ip, "[EXIST]"); return; }

            query = string.Format("UPDATE [User].[Users] SET password = N'{1}' WHERE id = {0};", user_id, password);
            bool isquery = SqlQuery.queryData(query);

            if (!isquery) { writeLog("Không thể update CSDL"); sendData(userClients[client_id].Ip, "[ERROR]"); }
            else { writeLog("Cập nhật mật khẩu thành công id: " + user_id); sendData(userClients[client_id].Ip, "[OK]"); }
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
                data += dt.Rows[i]["id"].ToString() + " ";
                data += dt.Rows[i]["roomname"].ToString().Replace(" ","_") + " ";
                data += dt.Rows[i]["type"].ToString() + ";";
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
        //Chạy query
        private void runQuery(UserClient host,string query, string[] items)
        {
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Sai query"); sendData(host.Ip, "[ERROR]"); return; }
            string data = string.Empty;
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                try
                {
                    for (int j = 0; j < items.Length; j++) data += dt.Rows[i][items[j]].ToString().Replace(" ","_") + " ";
                }
                catch (Exception ex) { writeLog("Sai query"); sendData(host.Ip, "[ERROR]"); return; }
                data = data.Trim() + ";";
            }    
        }
	private void forwardMessage(string receiverId, string message)
        {
            UserClient receiver = userClients[receiverId];
            if (receiver != null)
            {
                sendData(receiver.Ip, message);
                writeLog("Forwarded message to " + receiverId);
            }
        }

        private void saveMessageToDatabase(string senderId, string receiverId, string message)
        {
            try
            {
                string query = "INSERT INTO [Messages] (SenderId, ReceiverId, Message, Timestamp) VALUES (@SenderId, @ReceiverId, @Message, @Timestamp)";
                using (SqlConnection conn = new SqlConnection("Your_Connection_String"))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", senderId);
                        cmd.Parameters.AddWithValue("@ReceiverId", receiverId);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.Parameters.AddWithValue("@Timestamp", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
                writeLog("Saved message to database");
            }
            catch (Exception ex)
            {
                writeLog("Error saving message to database: " + ex.Message);
            }
        }

        private void saveEmotionToDatabase(string senderId, string messageId, string emotion)
        {
            try
            {
                string query = "INSERT INTO [Emotions] (SenderId, MessageId, Emotion, Timestamp) VALUES (@SenderId, @MessageId, @Emotion, @Timestamp)";
                using (SqlConnection conn = new SqlConnection("Your_Connection_String"))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", senderId);
                        cmd.Parameters.AddWithValue("@MessageId", messageId);
                        cmd.Parameters.AddWithValue("@Emotion", emotion);
                        cmd.Parameters.AddWithValue("@Timestamp", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
                writeLog("Saved emotion to database");
            }
            catch (Exception ex)
            {
                writeLog("Error saving emotion to database: " + ex.Message);
            }
        }
        private void forwardEmotion(string senderId, string messageId, string emotion)
        {
            foreach (var client in userClients)
            {
                sendData(client.Value.Ip, $"./emotion {senderId} {messageId} {emotion}");
                writeLog("Forwarded emotion to " + client.Key);
            }
        }

        private const int MAX_FILE_SIZE = 100 * 1024 * 1024; // 100MB

        private void handleFileTransfer(string command)
        {
            string[] cmdsplit = command.Split(" ");
            string senderId = cmdsplit[1];
            string receiverId = cmdsplit[2];
            string fileType = cmdsplit[3];
            string fileName = cmdsplit[4];
            byte[] fileData = Convert.FromBase64String(cmdsplit[5]);

            if (fileData.Length > MAX_FILE_SIZE)
            {
                writeLog($"File size exceeds 100MB limit. Actual size: {fileData.Length / (1024 * 1024)}MB");
                return;
            }

            saveFileToDatabase(senderId, receiverId, fileType, fileName, fileData);
            forwardFile(receiverId, fileType, fileName, fileData);
        }

        private void saveFileToDatabase(string senderId, string receiverId, string fileType, string fileName, byte[] fileData)
        {
            try
            {
                string query = "INSERT INTO [Files] (SenderId, ReceiverId, FileType, FileName, FileData, Timestamp) VALUES (@SenderId, @ReceiverId, @FileType, @FileName, @FileData, @Timestamp)";
                using (SqlConnection conn = new SqlConnection("Your_Connection_String"))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", senderId);
                        cmd.Parameters.AddWithValue("@ReceiverId", receiverId);
                        cmd.Parameters.AddWithValue("@FileType", fileType);
                        cmd.Parameters.AddWithValue("@FileName", fileName);
                        cmd.Parameters.AddWithValue("@FileData", fileData);
                        cmd.Parameters.AddWithValue("@Timestamp", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
                writeLog("Saved file to database");
            }
            catch (Exception ex)
            {
                writeLog("Error saving file to database: " + ex.Message);
            }
        }

        private void forwardFile(string receiverId, string fileType, string fileName, byte[] fileData)
        {
            UserClient receiver = userClients[receiverId];
            if (receiver != null)
            {
                string fileDataBase64 = Convert.ToBase64String(fileData);
                sendFile(receiver, $"./file {fileType} {fileName} {fileDataBase64}");
                writeLog("Forwarded file to " + receiverId);
            }
        }


        private void sendFile(UserClient uc, string data)
        {
            using (UdpClient udpClient = new UdpClient())
            {
                byte[] sendBytes = Encoding.UTF8.GetBytes(data);
                int maxChunkSize = 65000; // Slightly less than maximum UDP packet size for safety
                int chunkId = 0;
                int totalChunks = (int)Math.Ceiling((double)sendBytes.Length / maxChunkSize);

                for (int i = 0; i < sendBytes.Length; i += maxChunkSize)
                {
                    int remainingBytes = Math.Min(maxChunkSize, sendBytes.Length - i);
                    byte[] chunk = new byte[remainingBytes + 8]; // 4 bytes for chunkId, 4 bytes for totalChunks

                    Array.Copy(BitConverter.GetBytes(chunkId), 0, chunk, 0, 4);
                    Array.Copy(BitConverter.GetBytes(totalChunks), 0, chunk, 4, 4);
                    Array.Copy(sendBytes, i, chunk, 8, remainingBytes);

                    udpClient.Send(chunk, chunk.Length, uc.Ip);
                    chunkId++;
                }
            }
        }

        private string receiveFile(UdpClient udp)
        {
            IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, 0);
            Dictionary<int, byte[]> receivedChunks = new Dictionary<int, byte[]>();
            int totalChunks = -1;

            while (true)
            {
                Byte[] receiveBytes = udp.Receive(ref RemoteIpEndPoint);
                int chunkId = BitConverter.ToInt32(receiveBytes, 0);
                int currentTotalChunks = BitConverter.ToInt32(receiveBytes, 4);

                if (totalChunks == -1)
                {
                    totalChunks = currentTotalChunks;
                }

                byte[] chunkData = new byte[receiveBytes.Length - 8];
                Array.Copy(receiveBytes, 8, chunkData, 0, chunkData.Length);
                receivedChunks[chunkId] = chunkData;

                if (receivedChunks.Count == totalChunks)
                {
                    break;
                }
            }

            List<byte> completeData = new List<byte>();
            for (int i = 0; i < totalChunks; i++)
            {
                completeData.AddRange(receivedChunks[i]);
            }

            string data = Encoding.UTF8.GetString(completeData.ToArray());
            return data;
        }
        private void saveVoiceMessageToDatabase(string senderId, string receiverId, string audioBase64)
        {
            string query = "INSERT INTO [Messages].[Messages] (sender_id, receiver_id, message, date, time, type) VALUES (@senderId, @receiverId, @audioBase64, GETDATE(), GETDATE(), 'voice')";
            List<SqlParameter> parameters = new List<SqlParameter>
    {
        new SqlParameter("@senderId", senderId),
        new SqlParameter("@receiverId", receiverId),
        new SqlParameter("@audioBase64", audioBase64)
    };

            string connectionString = "Connected";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters.ToArray());

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }


        private void forwardVoiceMessage(string receiverId, string audioBase64)
        {
            UserClient receiver = userClients[receiverId];
            if (receiver != null)
            {
                sendData(receiver.Ip, audioBase64);
            }
        }

        private void saveGroupMessageToDatabase(string senderId, string roomId, string message)
        {
            try
            {
                string query = "INSERT INTO [GroupMessages] (SenderId, RoomId, Message, Timestamp) VALUES (@SenderId, @RoomId, @Message, @Timestamp)";
                using (SqlConnection conn = new SqlConnection("Your_Connection_String"))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", senderId);
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.Parameters.AddWithValue("@Timestamp", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
                writeLog("Saved group message to database");
            }
            catch (Exception ex)
            {
                writeLog("Error saving group message to database: " + ex.Message);
            }
        }

        private void forwardGroupMessage(string roomId, string senderId, string message)
        {
            Room room = Rooms.Find(r => r.Id == roomId);
            if (room != null)
            {
                foreach(var member in room.Members)
                {
                    UserClient receiver = null;
                    foreach (var client in userClients)
                        if (client.Value.Id == member.Value.Id) receiver = client.Value;
                    if (receiver != null && receiver.Id != senderId)
                    {
                        sendData(receiver.Ip, $"./groupmessage {roomId} {senderId} {message}");
                        writeLog($"Forwarded group message to {receiver.Id} in room {roomId}");
                    }
                }
            }
            else
            {
                writeLog($"Room with id {roomId} not found");
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
