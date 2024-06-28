using System.Data;
using System.Windows.Input;
using System;
using Microsoft.Data.SqlClient;
using System.Threading;
using Sharing_Place.Models;
using Sharing_Place.Shells;
namespace Sharing_Place.Views;

public partial class Register : ContentPage
{
    public Register()
    {
        InitializeComponent();
    }

    private async void OnReturnLoginClick(object sender, EventArgs e)
    {
        await Navigation.PopAsync();
    }

    private async void OnRegisterClicked(object sender, EventArgs e)
    {
        loadingIndicator.IsRunning = true;
        if (txtFname.Text == string.Empty || txtLname.Text==string.Empty ||
            txtUser.Text == string.Empty || txtPass.Text==string.Empty ||
            txtRpPass.Text == string.Empty || txtEmail.Text==string.Empty)
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "Textboxes cannot be empty", "Retry");
            return;
        }
        if (txtPass.Text != txtRpPass.Text)
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "Repeat password is not match", "Retry");
            return;
        }
        if (!txtEmail.Text.Contains("@") || !txtEmail.Text.Contains(".") || (txtEmail.Text.IndexOf("@") > txtEmail.Text.LastIndexOf(".")))
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "Email format is incorrect", "Retry");
            return;
        }
        string hashpass = SecurePasswordHasher.Hash(txtPass.Text.Trim());
        string fullname = txtLname.Text.Trim() + " " + txtFname.Text.Trim();
        //Command:  ./register <client_id> <username> <email> <password> <fullname>
        string command = string.Format("./register {0} {1} {2} {3} {4}", 
            ServerConnect.Id, txtUser.Text.Trim(), txtEmail.Text.Trim(), hashpass, fullname);
        string data = ServerConnect.getData(command);
        if (data.Contains("[EXIST]"))
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "The username is already exist", "Retry");
            return;
        }
        if (!data.Contains("[OK]"))
        {
            loadingIndicator.IsRunning = false;
            await DisplayAlert("Alert", "Cannot create account, try again later", "Retry");
            return;
        }
        string[] dsplit = data.Split(" ");
        SignIn.UserAccount = new User(dsplit[1], txtUser.Text.Trim(), txtEmail.Text.Trim(), fullname.Replace(" ","_"));
        loadingIndicator.IsRunning = false;
        await DisplayAlert("Congratulation", "Register success", "OK");
        Application.Current.MainPage = new MenuShell();
        // Work In Progress
    }
}