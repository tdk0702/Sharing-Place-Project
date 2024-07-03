using Sharing_Place.Models;
using Sharing_Place.Shells;

namespace Sharing_Place.Views.ForgetViews;

public partial class ForgetPassword : ContentPage
{
    string PIN = string.Empty;
    string user_id = string.Empty;
	public ForgetPassword()
	{
		InitializeComponent();
	}

    private async void onClickReset(object sender, EventArgs e)
    {
        if (tbxPIN.Text.Trim() == string.Empty) { await DisplayAlert("Alert", "Please input OTP", "Retry"); return; }
        if (PIN == tbxPIN.Text.Trim()) { await Navigation.PushAsync(new RenewPass(user_id)); return; }
    }
	private void onClickBack(object sender, EventArgs e) 
	{
        Application.Current.MainPage = new LoginShell();
    }

    private async void sendOTP_Click(object sender, EventArgs e)
    {
        if (tbxUser.Text.Trim() == "test@gm.com") { await DisplayAlert("Tester", "PIN: 24680", "OK"); PIN = "24680"; return; }
        if (tbxUser.Text.Trim() == string.Empty) { await DisplayAlert("Alert", "Please input the username or email", "Retry"); return; }
        string command = string.Format("./forgetpass {0} {1}", ServerConnect.Id, tbxUser.Text.Trim());
        string data = ServerConnect.getData(command);
        if (data.Contains("[EMPTY]"))
        {
            await DisplayAlert("Alert", "Your account is not exist", "Retry"); 
            return;
        }
        if (data.Contains("[ERROR]"))
        {
            await DisplayAlert("Alert", "Server cannot respond now, try again later", "Retry");
            return;
        }
        user_id = data.Split(" ")[1];
        PIN = data.Split(" ")[2];
        await DisplayAlert("", "A PIN is sent to your email.", "OK");
    }
}