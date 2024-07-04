using Microsoft.Maui.Controls;
using Sharing_Place.Models;

namespace Sharing_Place.Views
{
    public partial class PostDetail : ContentPage
    {
        public PostDetail(Post post)
        {
            InitializeComponent();
            userImage.Source = post.UserImage;
            userNameLabel.Text = post.UserName;
            timeAgoLabel.Text = post.TimeAgo;
            bodyLabel.Text = post.Body;

            if (!string.IsNullOrEmpty(post.MediaFilePath))
            {
                postImage.Source = post.MediaFilePath;
            }
            else
            {
                postImage.IsVisible = false;
            }
        }

        private async void btnComment_Click(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new CommentPage());
        }
        private async void btnShare_Click(object sender, EventArgs e)
        {
            var action = await DisplayActionSheet("Share Options", "Cancel", null,
                "Chia sẻ lên bảng Feed", "Chia sẻ lên tin của bạn");

            switch (action)
            {
                case "Chia sẻ lên bảng Feed":
                    await DisplayAlert("Shared", "Shared to Feed", "OK");
                    break;
                case "Chia sẻ lên tin của bạn":
                    await DisplayAlert("Shared", "Shared to Your Story", "OK");
                    break;
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