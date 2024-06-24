using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Net;
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
        List<UserClient> userClients = new List<UserClient>();
        List<Room> Rooms = new List<Room>();
        public MenuServer()
        {
            InitializeComponent();
        }

        private void MenuServer_Load(object sender, EventArgs e)
        {
            CheckForIllegalCrossThreadCalls = false;
            clearAll();

            LogMenu logMenu = new LogMenu();
            logMenu.Show();

            writeLog("Connecting to SQL Database");
            new Thread(() => connectSQL()).Start();
            while (!isSQLConnected) { Thread.Sleep(1000); writeLog("Waiting to connect to SQL Database..."); }
            writeLog("Connected to SQL Database, ready to start Server");

            writeLog("Starting Server.");
            new Thread(() => startServer()).Start();

            loadData();
        }
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
            using (UdpClient udpClient = new UdpClient(7070))
            {
                while (true)
                {
                    string data = receiveData(udpClient);
                    //Dữ liệu không đúng định dạng sẽ bỏ qua
                    if (!data.Contains("./")) continue;
                    runCommand(data);
                }
            }
        }
        private string receiveData(UdpClient udp)
        {
            IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, 0);
            Byte[] receiveBytes = udp.Receive(ref RemoteIpEndPoint);
            string data = Encoding.UTF8.GetString(receiveBytes);
            return data;
        }
        private void sendData(UserClient uc, string data)
        {
            using (UdpClient udpClient = new UdpClient())
            {
                Byte[] sendBytes = Encoding.ASCII.GetBytes(data);
                udpClient.Send(sendBytes, sendBytes.Length, uc.IPaddress);
            }
        }
        private void runCommand(string command)
        {
            //Kết nối Server với Client
            if (command.Contains("./connect"))
            {
                //Command:  ./connect <id> <ip>
                //Exxample: ./connect 000001 192.168.1.100
                string[] cmdsplit = command.Split(" ");
                connectClient(cmdsplit[1], cmdsplit[2]);
                return;
            }
            //Lấy dữ liệu View của Id
            if (command.Contains("./loadview"))
            {
                //Command:  ./loadview <id> <view> [<subview_id>]
                //Example: ./loadview 000001 rooms 
                //Example: ./loadview 000001 roompost 1 
                string[] cmdsplit = command.Split(" ");
                if (cmdsplit.Length < 4)
                    loadView(cmdsplit[1], cmdsplit[2]);
                else
                    loadView(cmdsplit[1], cmdsplit[2], cmdsplit[3]);
                return;
            }
        }
        //Nhận lệnh connect và gửi lại xác nhận.
        private void connectClient(string id, string ip)
        {
            lbxClients.Items.Add("Client ID: " + id + " (" + ip + ")");
            UserClient uc = new UserClient(id, new IPEndPoint(IPAddress.Parse(ip), 7070));
            userClients.Add(uc);
            writeLog("Đã kết nối", uc);
            sendData(uc, "[CONNECTED]");
        }
        private void loadView(string id, string view, string subview_id = "-1")
        {
            UserClient client = null;
            foreach (UserClient uc in userClients)
                if (uc.Id == id) { client = uc; break; }
            if (client == null) { writeLog("Lỗi - Không tìm thấy client có id: " + id); return; }

            if (view.Contains("rooms")) { loadListRooms(client); return; }
            if (view.Contains("roompost")) { loadListRoomPost(client, subview_id); return; }
        }
        private void loadListRooms(UserClient uc)
        {
            string query = "SELECT id, roomname, type FROM [Rooms].[Rooms], [Rooms].[Members] WHERE id = room_id AND [Rooms].[Members].user_id = " + uc.Id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count < 1) { writeLog("[EMPTY]", uc); sendData(uc, "[EMPTY]"); return; }
            string data = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                data += dt.Rows[i]["id"] + " ";
                data += dt.Rows[i]["roomname"] + " ";
                data += dt.Rows[i]["type"] + ";";
            }
            writeLog(data, uc);
            sendData(uc, data);
        }
        //Load dữ liệu bài viết phòng
        private void loadListRoomPost(UserClient uc, string room_id)
        {
            if (room_id == "-1") { writeLog("Lỗi - Không tìm thấy room có id: " + room_id); return; }
            string query = "SELECT id, roomname, type FROM [Rooms].[Rooms], [Rooms].[Members] WHERE id = room_id AND [Rooms].[Members].user_id = " + uc.Id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count < 1) { sendData(uc, "[EMPTY]"); return; }
            string data = string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                data += dt.Rows[i]["id"] + " ";
                data += dt.Rows[i]["roomname"] + " ";
                data += dt.Rows[i]["type"] + ";";
            }
            sendData(uc, data);
        }

        //Load dữ liệu danh sách thông tin User khi có DataTable
        private List<UserInfo> loadUsersInfo(DataTable dt)
        {
            List<UserInfo> Users = new List<UserInfo>();
            for (int i = 0; i < dt.Rows.Count; i++) Users.Add(UserInfo.loadUserInfo(dt, i));
            return Users;
        }
        //Load dữ liệu danh sách bài viết khi có DataTable
        private List<Post> loadPosts(DataTable dt)
        {
            List<Post> Posts = new List<Post>();
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
                Posts.Add(post);
            }
            return Posts;
        }
        //Load dữ liệu emotes khi có id bài viết
        private List<Emotion> loadEmotions(string post_id)
        {
            List<Emotion> emotions = new List<Emotion>();
            string query = "SELECT * FROM [Post].[Emotions] WHERE post_id = " + post_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không có dữ liệu emote của bài viết id: " + post_id); return emotions; }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string id = dt.Rows[i]["user_id"].ToString();
                string type = dt.Rows[i]["type"].ToString();
                Emotion emotion = new Emotion(id, type);
                emotions.Add(emotion);
            }
            return emotions;
        }
        //Load dữ liệu comment khi có id bài viết
        private List<Comment> loadComments(string post_id)
        {
            List<Comment> comments = new List<Comment>();
            string query = "SELECT * FROM [Post].[Comments] WHERE post_id = " + post_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không có dữ liệu comment của bài viết id: " + post_id); return comments; }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string user_id = dt.Rows[i]["user_id"].ToString();
                string body = dt.Rows[i]["body"].ToString();
                Comment comment = new Comment(user_id, body);
                comments.Add(comment);
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
        private List<UserInfo> loadRoomMembers(string room_id)
        {
            string query = "SELECT [User].[Info].* FROM [Room].[Members], [User].[Info] WHERE user_id = _id AND room_id = " + room_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không thấy dữ liệu thành viên của phòng có id: " + room_id); return new List<UserInfo>(); }
            return loadUsersInfo(dt);
        }
        //Load dữ liệu bài viết của phòng với id
        private List<Post> loadRoomPosts(string room_id)
        {
            string query = "SELECT [PP].* FROM [Room].[Posts], [Post].[Posts] AS [PP] WHERE post_id = id AND room_id = " + room_id + ";";
            DataTable dt = SqlQuery.getData(query);
            if (dt.Rows.Count <= 0) { writeLog("Không thấy dữ liệu bài viết của phòng có id: " + room_id); return new List<Post>(); }
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
        public static void writeLog(string data, UserClient uc = null)
        {
            if (uc != null)
                LogMenu.rtbxLog.Text += DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " " + uc.Id + ": " + data + "\r\n";
            else
                LogMenu.rtbxLog.Text += DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " Server: " + data + "\r\n";
        }

        private void btnAllClients_Click(object sender, EventArgs e)
        {
            ListAccount la = new ListAccount();
            la.Show();
        }

        private void btnStartServer_Click(object sender, EventArgs e)
        {
        }
    }
}
