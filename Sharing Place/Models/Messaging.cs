using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sharing_Place.Models
{
    public class Messaging
    {
        public string Id { get; set; }
        public string toId { get; set; }
        public bool isGroup { get; set; }
        public List<string> Body { get; set; }
        public Messaging()
        {
            Id = "0";
            toId = "1";
            isGroup = false;
            Body = new List<string>(){"Hello", "Test sending message", "OK"};
        }
        public Messaging(string id, string toid, List<string> body = null, bool isgr = false)
        {
            this.Id = id;
            this.toId = toid;
            this.isGroup = isgr;
            if (body != null) this.Body = body;
            else this.Body = new List<string>();
        }
    }
}
