using Microsoft.Maui.Controls;
using Sharing_Place.Models;

namespace Sharing_Place.Views
{
    public partial class PostDetail : ContentPage
    {
        private readonly Post _post;
        public PostDetail(Post post)
        {
            InitializeComponent();
            userImage.Source = post.ImagePath ?? "default-user-image.jpg";
            userNameLabel.Text = post.Title;
            timeAgoLabel.Text = post.CreatedAt.ToString("g");
            bodyLabel.Text = post.Body;
            _post = post;


            if (!string.IsNullOrEmpty(post.ImagePath))
            {
                postImage.Source = post.ImagePath;
            }
            else if (!string.IsNullOrEmpty(post.VideoPath))
            {
                // You can add a video player here if you want to support video playback
                postImage.Source = "video-thumbnail-placeholder.jpg"; // Placeholder for video
            }
            else
            {
                postImage.IsVisible = false;
            }
        }

        private async void btnComment_Click(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new CommentPage(_post.Id));
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

    }
    public class Post
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public DateTime CreatedAt { get; set; }
        public string ImagePath { get; set; }
        public string VideoPath { get; set; }
    }
}