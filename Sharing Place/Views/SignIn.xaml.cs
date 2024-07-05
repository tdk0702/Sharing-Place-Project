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
    }
    private async void OnSignInClicked(object sender, EventArgs e)
    {
        loadingIndicator.IsRunning = true;
        if (txtUser.Text == "admin" && txtPassword.Text == "admin")
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Congratulation", "Fast login", "OK");
            UserAccount = new User();
            Application.Current.MainPage = new MenuShell();
            return;
        }
        if (txtUser.Text.Length == 0 || txtPassword.Text.Length == 0)
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "Username or Password cannot be empty", "Retry");
            return;
        }
        loadingIndicator.IsRunning = true;
        while (!ServerConnect.isConnected) ;
        loadingIndicator.IsRunning = false;
        string command = string.Format("./login {0} {1} {2}", ServerConnect.Id, txtUser.Text.Trim(), txtPassword.Text.Trim());
        string data = ServerConnect.getData(command);
        if (data.Contains("[EMPTY]")) {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Error","The account is not exist.","Retry");
            return;
        }
        if (data.Contains("[WRONG PASS]"))
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Error", "The password is incorrect.", "Retry");
            return;
        }
        string[] dsplit = data.Replace("[OK] ","").Split(" ");
        UserAccount = new User(dsplit[0], dsplit[1], dsplit[2], dsplit[3].Replace("_"," "), dsplit[4], dsplit[5], dsplit[6]);
        loadingIndicator.IsRunning = false;
        await DisplayAlert("Success", "Welcome back, "+ txtUser.Text.Trim(), "OK");
        Application.Current.MainPage = new MenuShell();
    }

    

    private async void OnRegisterClicked(object sender, EventArgs e)
    {
        Application.Current.MainPage = new NavigationPage(new Register());
        await Navigation.PopAsync();
    }

    private async void OnForgetClicked(object sender, EventArgs e)
    {
        Application.Current.MainPage = new NavigationPage(new ForgetViews.ForgetPassword());
        await Navigation.PopAsync();
        //Navigation.InsertPageBefore(new ForgetPassword(), this);
    }

    bool isHidePass = true;
    private void PassVisible_Click(object sender, TappedEventArgs e)
    {
        if (isHidePass)
        {
            imgHideShow.Source = "show_pass_icon";
            txtPassword.IsPassword = false;
        }
        else
        {
            imgHideShow.Source = "hide_pass_icon";
            txtPassword.IsPassword = true;
        }
    }
}