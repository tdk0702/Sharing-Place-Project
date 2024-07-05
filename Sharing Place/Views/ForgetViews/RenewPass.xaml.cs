using Sharing_Place.Models;
using Sharing_Place.Shells;
namespace Sharing_Place.Views.ForgetViews;

public partial class RenewPass : ContentPage
{
    string User_id = string.Empty;
	public RenewPass()
	{
		InitializeComponent();
	}

    public RenewPass(string id)
    {
        InitializeComponent();
        User_id = id;
    }
    bool isHidePass = true;
    private void PassVisible_Click(object sender, TappedEventArgs e)
    {

        isHidePass = !isHidePass;
        if (isHidePass)
        {
            imgHideShow.Source = "show_pass_icon";
            tbxPass.IsPassword = false;
            tbxRePass.IsPassword = false;
        }
        else
        {
            imgHideShow.Source = "hide_pass_icon";
            tbxPass.IsPassword = true;
            tbxRePass.IsPassword = true;
        }
    }

    private async void resetPass_Click(object sender, EventArgs e)
    {
        if (tbxPass.Text.Trim() == string.Empty || tbxRePass.Text.Trim() == string.Empty)
        {
            await DisplayAlert("Alert", "The Password Textbox is empty", "Retry");
            return;
        }
        if (tbxPass.Text.Trim() != tbxRePass.Text.Trim())
        {
            await DisplayAlert("Alert", "The Repeat Password is not similar", "Retry");
            return;
        }
        bool isRenew = renewPass(tbxPass.Text.Trim());
        if (!isRenew)
        {
            await DisplayAlert("Alert", "Server not respond now, try again later.", "Retry");
            return;
        }
        await DisplayAlert("Congratulation", "The Password is renew", "OK");
        Application.Current.MainPage = new LoginShell();
    }
    private bool renewPass(string pass)
    {
        string passhash = SecurePasswordHasher.Hash(tbxPass.Text.Trim());
        string command = string.Format("./renewpass {0} {1} {2}", ServerConnect.Id, User_id , passhash);
        string data = ServerConnect.getData(command);
        if (data.Contains("[OK]")) return true;
        return false;
    }
}