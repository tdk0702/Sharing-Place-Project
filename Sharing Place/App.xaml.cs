using Sharing_Place.Views;
using Sharing_Place.Shells;
using Sharing_Place.Models;
using System.Net;
using System.Text;

namespace Sharing_Place
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
            MainPage = new LoginShell();
;            new Thread(() =>{ connectServer(); }).Start();
        }
        private void connectServer()
        {
            //loadingIndicator.IsRunning = true;
            ServerConnect.Client = new ServerConnect().getIP();
            string data = null;
            new Thread(() =>
            {
                data = ServerConnect.receivePacket();
            }).Start();
            int net = 0;
            string ip = ServerConnect.Client.Address.ToString();
            ip = ip.Substring(0, ip.LastIndexOf(".") + 1);
            while (data == null)
            {
                if (net < 256) net = (net + 1) % 256;
                try {
                //ServerConnect.sendServer("./connect " + ServerConnect.Client.Address.ToString());
                    ServerConnect.sendPacket("./connect " + ServerConnect.Client.Address.ToString(),
                        new IPEndPoint(IPAddress.Parse(ip + net.ToString()), 7070));
                }
                catch (Exception ex) { Console.WriteLine("Failed connecting to " + ip + net.ToString()); }
                Thread.Sleep(1000);
            }
            //loadingIndicator.IsRunning = false;
            //Receive: [OK] 192.168.1.1 1 172.17.7.11
            string[] datasplit = data.Split(" ");
            ServerConnect.Id = datasplit[2];
            ServerConnect.Server = new IPEndPoint(IPAddress.Parse(datasplit[3]), 7070);
            ServerConnect.isConnected = true;
        }
    }
}
