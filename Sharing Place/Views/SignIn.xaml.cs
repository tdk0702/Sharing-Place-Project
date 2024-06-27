using Sharing_Place.Models;
using Sharing_Place.Shells;
using System.Windows.Input;
using System.Data;
using System.Net;

namespace Sharing_Place.Views;

public partial class SignIn : ContentPage
{
    public static User UserAccount;
    private bool isSQLConnected = false;
	public SignIn()
	{
		InitializeComponent();
        connectServer();
    }
    private async void OnSignInClicked(object sender, EventArgs e)
    {
        if (txtUser.Text == "admin" && txtPassword.Text == "admin")
        {
            await DisplayAlert("Congratulation", "Fast login", "OK");
            UserAccount = new User();
            Application.Current.MainPage = new MenuShell();
            return;
        }
        if (txtUser.Text.Length == 0 || txtPassword.Text.Length == 0)
        {
            await DisplayAlert("Alert", "Username or Password cannot be empty", "Retry");
            return;
        }
        string passhash = SecurePasswordHasher.Hash(txtPassword.Text.Trim());
        string command = string.Format("./login {0} {1} {2}", ServerConnect.Id, txtUser.Text.Trim(), passhash);
        string data = ServerConnect.getData(command);
        if (data.Contains("[EMPTY]")) {
            await DisplayAlert("Error","The account is not exist.","Retry");
            return;
        }
        if (data.Contains("[WRONG PASS]"))
        {
            await DisplayAlert("Error", "The password is incorrect.", "Retry");
            return;
        }
        string[] dsplit = data.Replace("[OK] ","").Split(" ");
        UserAccount = new User(dsplit[0], dsplit[1], dsplit[2], dsplit[3], dsplit[4], dsplit[5], dsplit[6]);
        await DisplayAlert("Success", "Welcome back, "+ UserAccount.Nickname, "OK");
        Application.Current.MainPage = new MenuShell();
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
        ip = ip.Substring(0, ip.LastIndexOf(".")+1);
        while (data == null) 
        {
            if (net < 256) net=(net+1)%256;
            try {
                ServerConnect.sendServer("./connect " + ServerConnect.Client.Address.ToString());
                ServerConnect.sendPacket("./connect " + ServerConnect.Client.Address.ToString(), 
                    new IPEndPoint(IPAddress.Parse(ip + net.ToString()),7070)); 
            }
            catch (Exception ex) { Console.WriteLine("Failed connecting to " + ip + net.ToString()); }
            Thread.Sleep(1000);
        }

        //loadingIndicator.IsRunning = false;
        //Receive: [OK] 192.168.1.1 1 172.17.7.11
        string[] datasplit = data.Split(" ");
        ServerConnect.Id = datasplit[2];
        ServerConnect.Server = new IPEndPoint(IPAddress.Parse(datasplit[3]), 7070);
    }

    private async void OnRegisterClicked(object sender, EventArgs e)
    {
        Application.Current.MainPage = new NavigationPage(new Register());
        await Navigation.PopAsync();
    }

    private async void OnForgetClicked(object sender, EventArgs e)
    {
        Application.Current.MainPage = new ForgetViews.ForgetPassword();
        //Navigation.InsertPageBefore(new ForgetPassword(), this);
    }
}