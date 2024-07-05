using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sharing_Place.Models
{
    public class User
    {
        public string Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Fullname { get; set; }
        public string Nickname { get; set; }
        public string Birthdate { get; set; }
        public string Created_At { get; set; }
        public string Gender { get; set; }
        public string ImgAvt { get; set; }
        public bool IsOnline { get; set; }
        public User()
        {
            Id = "0";
            Username = "usertest";
            Email = "22520702@gm.uit.edu.vn";
            Fullname = "Admin Tester";
            Nickname = "Tester";
            Birthdate = "1/1/2000";
            Gender = "male";
            Created_At = "1-1-2000";
        }
        public User(string id, string username, string email, string fullname, 
            string nick="", string birth="1-1-2000", string gender="male", string created="1-1-2000")
        {
            Id = id;
            this.Username = username;
            this.Email = email;
            this.Fullname = fullname;
            this.Nickname = nick;
            if (birth.Trim() != string.Empty) this.Birthdate = birth;
            else this.Birthdate = "1-1-2000";
            this.Gender = gender;
            this.Created_At = created;
        }
        public bool isMale()
        {
            return !this.Gender.Contains("female");
        } 

        private void GetInfo(string id)
        {
            string query = string.Format("SELECT * FROM [User].[Users],[User].[Info] WHERE id = '{0}';", id);
            DataTable dt = SqlQuery.getData(query);
            Username = dt.Rows[0]["username"].ToString();
            Email = dt.Rows[0]["email"].ToString();
            Fullname = dt.Rows[0]["fullname"].ToString();
            Nickname = dt.Rows[0]["nickname"].ToString();
            Birthdate = dt.Rows[0]["birth"].ToString();
            Gender = dt.Rows[0]["gender"].ToString();
		}
    }
}
