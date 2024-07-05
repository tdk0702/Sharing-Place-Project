using Sharing_Place.Models;
using Sharing_Place.Views;

namespace Sharing_Place.Views;

public partial class SettingInfo : ContentPage
{
    string user_Id;
    public SettingInfo()
	{
		InitializeComponent();
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        loadInfo();
    }
    private void loadInfo()
    {
        lbUser.Text = SignIn.UserAccount.Username;
        lbName.Text = SignIn.UserAccount.Fullname;
        lbBirth.Text = SignIn.UserAccount.Birthdate;
        lbGender.Text = SignIn.UserAccount.Gender;
        lbEmail.Text = SignIn.UserAccount.Email;
    }
}