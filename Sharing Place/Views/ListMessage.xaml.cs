using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;
using System.Linq;
using Sharing_Place.Models;
using Sharing_Place.ViewModels;
namespace Sharing_Place.Views
{
    public partial class ListMessage : ContentPage
    {
        private ObservableCollection<User> _userSuggestions;
        public ReadOnlyObservableCollection<User> UserSuggestions { get; }
        public ObservableCollection<MessageModel> Messages { get; set; }
        public static Dictionary<string, string> ChatPerson = new Dictionary<string, string>();

        public ListMessage()
        {
            InitializeComponent();
            _userSuggestions = new ObservableCollection<User>();
            UserSuggestions = new ReadOnlyObservableCollection<User>(_userSuggestions);
            Messages = new ObservableCollection<MessageModel>();

            BindingContext = this;

            //loadListUser();
        }

        private void OnSearchBarTextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = e.NewTextValue?.Trim();

            if (string.IsNullOrWhiteSpace(searchText))
            {
                UserSuggestionListView.IsVisible = false;
            }
            else
            {
                UpdateUserSuggestions(searchText);
                UserSuggestionListView.IsVisible = true;
            }
        }

        private void OnUserSelected(object sender, SelectedItemChangedEventArgs e)
        {
            if (e.SelectedItem is User selectedUser)
            {
                Navigation.PushAsync(new Message(selectedUser));
                UserSuggestionListView.SelectedItem = null;
            }
        }

        private void UpdateUserSuggestions(string searchText)
        {
            var suggestions = GetUserSuggestions(searchText).ToList();
            _userSuggestions.Clear();
            foreach (var suggestion in suggestions)
            {
                _userSuggestions.Add(suggestion);
            }
        }

        private IEnumerable<User> GetUserSuggestions(string searchText)
        {
            var users = new List<User>
            {
                new User { Username = "quanglam", ImgAvt = "user1.png", IsOnline = true },
                new User {Username = "tdk0702", ImgAvt = "user2.png", IsOnline = false },
                new User { Username = "YelloIsMe", ImgAvt = "user3.png", IsOnline = true },
            };
            return users.Where(user => user.Username.Contains(searchText, StringComparison.OrdinalIgnoreCase));
        }
        protected override void OnAppearing()
        {
            base.OnAppearing();
            //loadListUser();
        }
        /*private void loadListUser()
        {
            string command =
            string.Format("./runquery {0} SELECT user1_id,user2_id,body FROM [User].[Messages],[User].[Info] WHERE (user1_id = {1} AND user2_id = _id)"
                + " OR (user2_id = {1} AND user1_id = _id);",
            ServerConnect.Id,SignIn.UserAccount.Id);
            string data = ServerConnect.getData(command);
            if (data.Contains("[EMPTY]")) return;
            data = data.Substring(data.IndexOf(" ") + 1);
            data = data.Substring(0, data.Length - 1);
            string[] dtsplit = data.Split(";");
                for (int i = 0; i < dtsplit.Length; i++)
                {
                    string[] dsplit = dtsplit[i].Split(" ");
                    if (dsplit[0].Contains(SignIn.UserAccount.Id)) ChatPerson.Add(dsplit[1], dsplit[2]);
                    else ChatPerson.Add(dsplit[0], dsplit[2]);
                }
        }*/
    }
    public class MessageModel
    {
        public string Name { get; set; }
        public string MessageText { get; set; }
        public string ImgAvt { get; set; }
    }
}
