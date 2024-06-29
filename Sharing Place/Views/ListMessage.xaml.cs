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

        public ListMessage()
        {
            InitializeComponent();
            _userSuggestions = new ObservableCollection<User>();
            UserSuggestions = new ReadOnlyObservableCollection<User>(_userSuggestions);
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
                new User { Username = "User1", ImgAvt = "user1.png", IsOnline = true },
                new User {Username = "User2", ImgAvt = "user2.png", IsOnline = false },
                new User { Username = "User3", ImgAvt = "user3.png", IsOnline = true },
            };

            return users.Where(user => user.Username.Contains(searchText, StringComparison.OrdinalIgnoreCase));
        }
    }
    public class MessageModel
    {
        public string Name { get; set; }
        public string MessageText { get; set; }
        public string ImgAvt { get; set; }
    }
}
