using Microsoft.Maui.Controls;
using Sharing_Place.Models;
using System.Collections.ObjectModel;

namespace Sharing_Place.Views
{
    public partial class PostMenu : ContentPage
    {
        public List<Post> Posts;

        public PostMenu()
        {
            InitializeComponent();
            Posts = new List<Post>()
            {
                new Post { Id = 1, Title = "Chào mừng đến với Sharing Place", 
                    Body = "Đây là bài post đầu tiên trên ứng dụng SP Mobile\r\nChào mừng đến với Sharing Place Mobile.", CreatedAt = DateTime.Now.AddHours(-2), 
                    ImagePath = "profile-pic.jpg" },
                new Post { Id = 2, Title = "Bài post từ tdk0702", 
                    Body = "Hôm nay trời đẹp thế, mặc dù mưa nhiều.", CreatedAt = DateTime.Now.AddHours(-1), 
                    ImagePath = "profile-pic.jpg" }
            };
        }
        protected override void OnAppearing()
        {
            base.OnAppearing();
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

        private void Post_Tapped(object sender, ItemTappedEventArgs e)
        {
            postsListView.SelectedItem = null;
        }
    }
}