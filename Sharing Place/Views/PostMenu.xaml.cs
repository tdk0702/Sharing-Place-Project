using Microsoft.Maui.Controls;
using Sharing_Place.Models;
using System.Collections.ObjectModel;

namespace Sharing_Place.Views
{
    public partial class PostMenu : ContentPage
    {
        public ObservableCollection<Post> Posts { get; set; }

        public PostMenu()
        {
            InitializeComponent();
            Posts = new ObservableCollection<Post>
            {
                new Post { UserName = "John Doe", Body = "Sample post content", TimeAgo = "2 hrs ago", UserImage = "profile-pic.jpg" },
                new Post { UserName = "Jane Smith", Body = "Another sample post", TimeAgo = "1 hr ago", UserImage = "profile-pic.jpg" }
            };
          
        }

        private async void OnNewPostsClicked(object sender, EventArgs e)
        {
            var newPostPage = new NewPostPage();
            newPostPage.PostCompleted += (source, post) =>
            {
                Posts.Add(Post);
            };
            await Navigation.PushAsync(newPostPage);
        }

        private async void OnPostSelected(object sender, SelectedItemChangedEventArgs e)
        {
            if (e.SelectedItem is Post selectedPost)
            {
                await Navigation.PushAsync(new PostDetail(selectedPost));
            }
        }
        public class Post
        {
            public string UserName { get; set; }
            public string Body { get; set; }
            public string TimeAgo { get; set; }
            public string UserImage { get; set; }
            public string MediaFilePath { get; set; }
        }
    }
}