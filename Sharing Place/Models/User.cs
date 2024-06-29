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
        public string Username { get; set; }
        public string Fullname { get; set; }
        public string Id { get; set; }
        public string Email { get; set; }
        public string Nickname { get; set; }
        public string Birth { get; set; }
        public bool Gender { get; set; }
        public string ImgAvt { get; set; }
        public bool IsOnline { get; set; }
        public int CommonFriendsCount { get; set; }
        public User()
        {
            Username = "usertest";
            Id = "0";
            Fullname = "Admin Tester";
            Nickname = "Tester";
            Email = "22520702@gm.uit.edu.vn";
            Birth = "1/1/2000";
            Gender = true;
        }

        public User(string id)
        {
            Id = id;
            GetInfo(id);
        }

        private void GetInfo(string id)
        {
            string query = string.Format("SELECT * FROM [User].[Users],[User].[Info] WHERE id = '{0}';", id);
            DataTable dt = SqlQuery.getData(query);
            Username = dt.Rows[0]["username"].ToString();
            Email = dt.Rows[0]["email"].ToString();
            Fullname = dt.Rows[0]["fullname"].ToString();
            Nickname = dt.Rows[0]["nickname"].ToString();
            Birth = dt.Rows[0]["birth"].ToString();
            Gender = !(dt.Rows[0]["gender"].ToString().Contains("female"));
		}
    }
}
