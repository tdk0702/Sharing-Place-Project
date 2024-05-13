using Sharing_Place.Models;
using System.Windows.Input;
using System.Data;

namespace Sharing_Place.Views;

public partial class SignIn : ContentPage
{
	public SignIn()
	{
		InitializeComponent();
	}
    private async void OnSignInClicked(object sender, EventArgs e)
    {
        if(txtUser.Text.Length == 0 || txtPassword.Text.Length == 0)
        {
            await DisplayAlert("Alert", "Username or Password cannot be empty", "Retry");
            return;
        }
        string query = string.Format("SELECT password FROM [User].[Users] WHERE username = N'{0}';", txtUser.Text.Trim());
        if (txtUser.Text.IndexOf('@') != -1 && txtUser.Text.IndexOf('@') < txtUser.Text.LastIndexOf('.'))
            query = string.Format("SELECT password FROM [User].[Users] WHERE email = N'{0}';", txtUser.Text.Trim());
        DataTable dt = SqlQuery.getData(query);
        if (dt.Rows.Count == 0)
        {
            await DisplayAlert("Alert", "The account is not exist", "Retry");
            return;
        }
        string passhash = SecurePasswordHasher.Hash(txtPassword.Text.Trim());
        if (passhash != dt.Rows[0]["password"].ToString())
        {
            await DisplayAlert("Alert", "The password is incorrect", "Retry");
            return;
        }
        await DisplayAlert("Congratulation", "Welcome back " + txtUser.Text, "OK");
        Application.Current.MainPage = new AppShell();
    }
    //public ICommand ForgotPasswordCommand => new Command(OnForgetClicked);
    //public ICommand RegisterCommand => new Command(OnRegisterClicked);

    private async void OnRegisterClicked(object sender, EventArgs e)
    {
        //await DisplayAlert("Alert", "Email or Password cannot be empty", "Retry");
        //Application.Current.MainPage = new Register();
        Application.Current.MainPage = new NavigationPage(new Register());
        await Navigation.PopAsync();
    }

    private async void OnForgetClicked(object sender, EventArgs e)
    {
        Navigation.InsertPageBefore(new ForgetPassword(), this);
        //await Navigation.PopAsync();
    }
}