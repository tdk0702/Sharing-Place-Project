using Sharing_Place.Shells;
using Sharing_Place.Models;
namespace Sharing_Place.Views;

public partial class ListFriend : ContentPage
{

    class Fr
    {
        string Id { get; set; }
        string Name { get; set; }
        public Fr(string id, string name)
        {
            Id = id;
            Name = name;
        }
    }
    public static Dictionary<string, string> Friends = new Dictionary<string, string>();
    List<Fr> Frs = new List<Fr>();
	public ListFriend()
	{
		InitializeComponent();
	}
    protected override void OnAppearing()
    {
        base.OnAppearing();
        loadFriendEx();
        //loadData();
    }
    private void loadFriendEx()
    {
        Friends.Add("9", "Dy Khoii");
        Friends.Add("1", "Quang Lamm");
        Friends.Add("2", "LamAdmin");
        Friends.Add("3", "KiênYello");
        Friends.Add("4", "Kien XYZ");
    }
    private void loadData()
    {

        //Load friend
        string command =
            string.Format("./runquery {0} SELECT friend_id,fullname FROM [User].[Friends],[User].[Info] WHERE user_id = {1} AND friend_id = _id;",
            ServerConnect.Id,SignIn.UserAccount.Id);
        string data = ServerConnect.getData(command);
        if (data.Contains("[EMPTY]")) return;
        data = data.Substring(data.IndexOf(" ") + 1);
        data = data.Substring(0, data.Length - 1);
            string[] dtsplit = data.Split(";");
            for (int i = 0; i < dtsplit.Length; i++)
            {
                string[] dsplit = dtsplit[i].Split(" ");
                Friends.Add(dsplit[0], dsplit[1]);
            }

        lbCount.Text = "You have " + Friends.Count.ToString() + " Friends";
        foreach (var friend in Friends) Frs.Add(new Fr(friend.Key, friend.Value));
        lvFriends.ItemsSource = Frs;
    }

    private void lvFriends_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        lvFriends.SelectedItem = null;
    }

    private void lvFriends_ItemSelected(object sender, SelectedItemChangedEventArgs e)
    {
        if (lvFriends.SelectedItem == null)
        {
            //string id = ((Fr)lvFriends.SelectedItem).Id;
            Navigation.PushAsync(new SettingInfo());
        }
    }
}