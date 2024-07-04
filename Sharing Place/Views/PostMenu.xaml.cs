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
                new Post { Id = 1, Title = "Sample Title 1", Body = "Sample post content", CreatedAt = DateTime.Now.AddHours(-2), ImagePath = "profile-pic.jpg" },
                new Post { Id = 2, Title = "Sample Title 2", Body = "Another sample post", CreatedAt = DateTime.Now.AddHours(-1), ImagePath = "profile-pic.jpg" }
            };
            postsListView.ItemsSource = Posts;
        }

        private async void OnNewPostsClicked(object sender, EventArgs e)
        {
            var newPostPage = new NewPostPage();
            newPostPage.PostCompleted += (source, post) =>
            {
                Posts.Add(post);
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
    }
}