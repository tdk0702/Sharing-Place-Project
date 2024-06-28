using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;
using System.Data;
using System.Data.SqlClient;

namespace SP_Server
{
    public class UserClient
    {
        public string Id;
        public IPEndPoint Ip;
        public UserClient(string id, IPEndPoint ip)
        {
            this.Id = id;
            this.Ip = ip;
        }
        public UserClient(IPEndPoint ip)
        {
            this.Ip = ip;
        }
    }
    public class User
    {
        public string Id;
        public string Username;
        public string Email;
        public UserInfo Info;
        public User(string id, string username, string email, UserInfo info)
        {
            this.Id = id;
            this.Username = username;
            this.Email = email;
            this.Info = info;
        }

        //Load dữ liệu tài khoản User khi có id
        public static User loadUser(string id)
        {
            string query = "SELECT * FROM [User].[Users], [User].[Info] WHERE id = _id AND id = " + id + ";";
            return loadUser(SqlQuery.getData(query));
        }

        //Load dữ liệu tài khoản User khi có DataTable
        public static User loadUser(DataTable dt, int index = 0)
        {
            string id = dt.Rows[index]["id"].ToString();
            string username = dt.Rows[index]["username"].ToString();
            string email = dt.Rows[index]["email"].ToString();
            UserInfo ui = UserInfo.loadUserInfo(dt, index);
            return new User(id, username, email, ui);
        }
    }
    public class UserInfo
    {
        public string Id;
        public string Fullname;
        public string Nickname;
        public string Gender;
        public string Birthdate;
        public string Avatar;
        public string Created_At;
        public UserInfo(string id, string fullname, string nickname, string birth, string gender, string avatar="", string created="1-1-2020")
        {
            this.Id = id;
            this.Fullname = fullname;
            this.Nickname = nickname;
            this.Birthdate = birth;
            this.Gender = gender;
            this.Avatar = avatar;
            this.Created_At = created;
        }

        //Load thông tin User khi có DataTable
        public static UserInfo loadUserInfo(DataTable dt, int index = 0)
        {
            string id = dt.Rows[index]["_id"].ToString();
            string fname = dt.Rows[index]["fullname"].ToString();
            string nname = dt.Rows[index]["nickname"].ToString();
            string birth = dt.Rows[index]["date_of_birth"].ToString();
            string gender = dt.Rows[index]["gender"].ToString();
            UserInfo ui = new UserInfo(id, fname, nname, birth, gender);
            return ui;
        }
    }
    public class Room
    {
        public string Id;
        public string Name;
        public string Description;
        public string Type; //private | public
        public string Owner;
        public Dictionary<string, Post> Posts;
        public Dictionary<string, UserInfo> Members;
        public Room(string id, string name, string type, string owner)
        {
            this.Id = id;
            this.Name = name;
            this.Owner = owner;
            this.Type = type;
            this.Posts = new Dictionary<string,Post>();
            this.Members = new Dictionary<string, UserInfo>();
        }
        public bool isPrivate()
        {
            return this.Type.Contains("private");
        }

    }

    public class Post
    {
        public string Id;
        public string Title;
        public string Body;
        public string Status;
        public string Owner;
        public Dictionary<string,Emotion> Emotions;
        public Dictionary<string,Comment> Comments;
        public Post(string id, string title, string body, string status, string owner)
        {
            this.Id = id;
            this.Title = title;
            this.Body = body;
            this.Status = status;
            this.Owner = owner;
            this.Emotions = new Dictionary<string, Emotion>();
            this.Comments = new Dictionary<string, Comment>();
        }
    }

    public class Emotion
    {
        public string User_id;
        public string Type;
        public Emotion(string user_id, string type)
        {
            this.User_id = user_id;
            this.Type = type;
        }
    }

    public class Comment
    {
        public string User_id;
        public string Body;
        public Comment(string user_id, string body)
        {
            this.User_id = user_id;
            this.Body = body;
        }
    }
    public static class SqlQuery
    {
        //private string SqlConnectString = @"Server=tcp:sharingplace.database.windows.net,1433;Initial Catalog=SharingPlaceDB;Persist Security Info=False;User ID=AdminSP;Password=Sharingplace@123;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;";
        //private const string SqlConnectString = @"Data Source=tcp:sharingplace.database.windows.net,1433;Initial Catalog=SharingPlaceDB;User ID=AdminSP;Password=Sharingplace@123;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;MultiSubnetFailover=True";
        private static string SqlConnectString = string.Format(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename={0}SP_db.mdf;Integrated Security=True;",Application.StartupPath);
        //private static string SqlConnectString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\Projects\GitHub\Sharing-Place-Project\SPServer\bin\Debug\net8.0-windows\SP_db.mdf;Integrated Security=True;";
        public static void testConnection()
        {
            SqlConnection sqlconnect = new SqlConnection(SqlConnectString);
            try { sqlconnect.Open(); }
            catch (Exception ex) { Console.WriteLine("Không thể kết nối SQL Err: " + ex.ToString()); }
        }
        public static DataTable getData(string query)
        {
            SqlConnection sqlconnect = new SqlConnection(SqlConnectString);
            sqlconnect.Open();
            DataTable dt = new DataTable();
            SqlCommand sqlcmd = new SqlCommand(query, sqlconnect);
            sqlcmd.CommandType = CommandType.Text;
            SqlDataAdapter sda = new SqlDataAdapter(sqlcmd);
            try { sda.Fill(dt); }
            catch (SqlException expt)
            {
                Console.WriteLine("Query sai định dạng.\r\nErr: " + expt.ToString());
                MenuServer.writeLog("Query sai định dạng hoặc lỗi không chạy lệnh.");
                return dt;
            }
            sqlconnect.Close();
            return dt;
        }
        public static bool queryData(string query)
        {
            using (SqlConnection SQLConnect = new SqlConnection(SqlConnectString))
            {
                SQLConnect.Open();
                using (SqlCommand cmd = new SqlCommand(query, SQLConnect))
                {
                    cmd.CommandType = CommandType.Text;
                    try { cmd.ExecuteNonQuery(); }
                    catch (SqlException expt)
                    {
                        MessageBox.Show("Query sai định dạng.\r\nErr: " + expt.ToString());
                        MenuServer.writeLog("Query sai định dạng hoặc lỗi không chạy lệnh.");
                        return false;
                    }
                }
            }
            return true;
        }

    }
}
