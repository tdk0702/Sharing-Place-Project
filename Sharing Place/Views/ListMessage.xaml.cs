using Microsoft.Maui.Controls;
using System.Collections.ObjectModel;
using System.Linq;
using Sharing_Place.Models;
using System.Windows.Input;
using System.Threading.Tasks;
using Sharing_Place.ViewModels;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace Sharing_Place.Views
{
    public partial class ListMessage : ContentPage, INotifyPropertyChanged
    {
        private readonly ObservableCollection<User> _friends;
        private bool _isUserSuggestionsVisible;
        public ObservableCollection<User> UserSuggestions { get; }
        public ObservableCollection<MessagesModel> Messages { get; }
        public ICommand DeleteMessageCommand { get; }
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
        public ListMessage()
        {
            InitializeComponent();
            _friends = InitializeFriends();
            UserSuggestions = new ObservableCollection<User>();
            Messages = new ObservableCollection<MessagesModel>();
            DeleteMessageCommand = new Command<MessagesModel>(ExecuteDeleteMessage);
            BindingContext = this;
        }

        private static ObservableCollection<User> InitializeFriends() => new()
        {
            new User { Username = "quanglam", ImgAvt = "user1.png", IsOnline = true },
            new User { Username = "tdk0702", ImgAvt = "user2.png", IsOnline = false },
            new User { Username = "YelloIsMe", ImgAvt = "user3.png", IsOnline = true },
        };

        private void ExecuteDeleteMessage(MessagesModel message)
        {
            if (message != null)
            {
                Messages.Remove(message);
            }
        }

        public bool IsUserSuggestionsVisible
        {
            get => _isUserSuggestionsVisible;
            set
            {
                if (_isUserSuggestionsVisible != value)
                {
                    _isUserSuggestionsVisible = value;
                    OnPropertyChanged();
                }
            }
        }

        private void OnSearchBarTextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = e.NewTextValue;
            UpdateUserSuggestions(searchText);
            IsUserSuggestionsVisible = !string.IsNullOrWhiteSpace(searchText);
        }

        private async void OnUserSelected(object sender, SelectionChangedEventArgs e)
        {
            if (e.CurrentSelection.FirstOrDefault() is User selectedUser)
            {
                ((CollectionView)sender).SelectedItem = null;
                await NavigateToMessagePage(selectedUser);
            }
        }

        private void UpdateUserSuggestions(string searchText)
        {
            var suggestions = _friends.Where(user => user.Username.Contains(searchText, StringComparison.OrdinalIgnoreCase));
            UserSuggestions.Clear();
            foreach (var suggestion in suggestions)
            {
                UserSuggestions.Add(suggestion);
            }
        }

        public void AddOrUpdateMessage(MessagesModel message)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var existingMessage = Messages.FirstOrDefault(m => m.Name == message.Name);
                if (existingMessage != null)
                {
                    existingMessage.Message = message.Message;
                    existingMessage.SentAt = message.SentAt;
                }
                else
                {
                    Messages.Add(message);
                }
                var orderedMessages = new ObservableCollection<MessagesModel>(Messages.OrderByDescending(m => m.SentAt));
                Messages.Clear();
                foreach (var m in orderedMessages)
                {
                    Messages.Add(m);
                }
            });
        }

        private async void OnMessageSelected(object sender, SelectionChangedEventArgs e)
        {
            if (e.CurrentSelection.FirstOrDefault() is MessagesModel selectedMessage)
            {
                var user = _friends.FirstOrDefault(u => u.Username == selectedMessage.Name);
                if (user != null)
                {
                    await NavigateToMessagePage(user);
                    MessagesListView.SelectedItem = null;
                }
            }
        }

        private async Task NavigateToMessagePage(User user)
        {
            var existingPage = Navigation.NavigationStack
                .OfType<Message>()
                .FirstOrDefault(p => p.chatUser.Username == user.Username);

            if (existingPage != null)
            {
                await Navigation.PushAsync(existingPage);
            }
            else
            {
                var newPage = new Message(user, AddOrUpdateMessage);
                await Navigation.PushAsync(newPage);
            }
        }
    }
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
    


