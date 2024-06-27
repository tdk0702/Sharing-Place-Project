using Microsoft.Maui.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Net;
using System.Text;

#if ANDROID
using Android.App;
using Android.Net;
using Android.Net.Wifi;
#endif

namespace Sharing_Place.Models
{
    public class ServerConnect
    {
        public static string Id;
        public static IPEndPoint Client;
        public static IPEndPoint Server = new IPEndPoint(IPAddress.Broadcast, 7070);
        public static string getData(string command)
        {
            string data = null;
            new Thread(() =>
            {
                data = ServerConnect.receivePacket();
            }).Start();
            ServerConnect.sendServer(command);
            while (data == null) Thread.Sleep(1000); 
            return data;
        }
        public static void sendServer(string data)
        {
            sendPacket(data, Server);

        }

        public static void sendPacket(string data,IPEndPoint hostname)
        {
            using (UdpClient udpClient = new UdpClient())
            {
                Byte[] sendBytes = Encoding.UTF8.GetBytes(data);
                udpClient.Send(sendBytes, sendBytes.Length, hostname);
                Console.WriteLine("Client >> " + data);
                Console.WriteLine("["+hostname.ToString()+"]");
            }
        }
        public static string receivePacket()
        {
            using (UdpClient udpClient = new UdpClient(7070))
            {
                while (true)
                {
                    //Nhận dữ liệu
                    IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any,0);
                    Byte[] receiveBytes = udpClient.Receive(ref RemoteIpEndPoint);
                    string data = Encoding.UTF8.GetString(receiveBytes);
                    //Dữ liệu không đúng định dạng sẽ bỏ qua
                    if (!data.Contains("]") || !data.Contains("[")) continue;
                    Console.WriteLine("Server >> " + data);
                    return data;
                }
            }
        }
        public IPEndPoint getIP()
        {
            IPAddress ip = IPAddress.Parse("127.0.0.1");
#if ANDROID
                WifiManager wifiManager = (WifiManager) Android.App.Application.Context.GetSystemService(Service.WifiService);
                int ipaddress = wifiManager.ConnectionInfo.IpAddress;
                ip = new IPAddress(ipaddress);
#endif
            return new IPEndPoint(ip, 7070);
        }
    }
}
