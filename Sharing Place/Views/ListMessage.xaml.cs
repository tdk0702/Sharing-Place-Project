using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;
using System.Linq;

namespace Sharing_Place.Views
{
    public partial class ListMessage : ContentPage
    {
        private ObservableCollection<User1> _userSuggestions;
        public ReadOnlyObservableCollection<User1> UserSuggestions { get; }

        public ObservableCollection<MessageModel> Messages { get; set; }

        public ListMessage()
        {
            InitializeComponent();
            _userSuggestions = new ObservableCollection<User1>();
            UserSuggestions = new ReadOnlyObservableCollection<User1>(_userSuggestions);
            Messages = new ObservableCollection<MessageModel>();

            BindingContext = this;
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
            if (e.SelectedItem is User1 selectedUser)
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

        private IEnumerable<User1> GetUserSuggestions(string searchText)
        {
            var users = new List<User1>
            {
                new User1 { Name = "User1", ImgAvt = "user1.png", IsOnline = true, CommonFriendsCount = 5 },
                new User1 { Name = "User2", ImgAvt = "user2.png", IsOnline = false, CommonFriendsCount = 3 },
                new User1 { Name = "User3", ImgAvt = "user3.png", IsOnline = true, CommonFriendsCount = 2 }
            };

            return users.Where(user => user.Name.Contains(searchText, StringComparison.OrdinalIgnoreCase));
        }
    }

    public class User1
    {
        public string Name { get; set; }
        public string ImgAvt { get; set; }
        public bool IsOnline { get; set; }
        public int CommonFriendsCount { get; set; }
    }

    public class MessageModel
    {
        public string Name { get; set; }
        public string MessageText { get; set; }
        public string ImgAvt { get; set; }
    }
}
