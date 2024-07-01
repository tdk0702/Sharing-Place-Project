using CommunityToolkit.Maui.Views;
using Microsoft.Maui.Controls;
using System.IO;
using System.Threading.Tasks;

namespace Sharing_Place.Views
{
    public partial class MediaViewPage : ContentPage
    {
        private readonly string mediaPath;
        private readonly bool isImage;

        public MediaViewPage(string mediaPath, bool isImage)
        {
            InitializeComponent();
            this.mediaPath = mediaPath;
            this.isImage = isImage;
            DisplayMedia();
        }

        private void DisplayMedia()
        {
            TitleLabel.Text = Path.GetFileName(mediaPath);

            if (isImage)
            {
                var image = new Image
                {
                    Source = ImageSource.FromFile(mediaPath),
                    Aspect = Aspect.AspectFit,
                    WidthRequest = 300,
                    HeightRequest = 300
                };
                MediaContainer.Children.Add(image);
            }
            else
            {
                var video = new MediaElement
                {
                    Source = mediaPath,
                    Aspect = Aspect.AspectFit,
                    WidthRequest = 300,
                    HeightRequest = 300,
                    ShouldAutoPlay = false,
                    ShouldShowPlaybackControls = true
                };
                MediaContainer.Children.Add(video);
            }
        }

        private async void OnDownloadButtonClicked(object sender, EventArgs e)
        {
            try
            {
                var fileName = Path.GetFileName(mediaPath);
                var destinationPath = Path.Combine(FileSystem.AppDataDirectory, fileName);

                using (var sourceStream = File.OpenRead(mediaPath))
                using (var destinationStream = File.Create(destinationPath))
                {
                    await sourceStream.CopyToAsync(destinationStream);
                }

                await DisplayAlert("Success", "File downloaded successfully.", "OK");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Failed to download file: {ex.Message}", "OK");
            }
        }
        private async void Exit(object sender, EventArgs e)
        {
            if (BindingContext is User1 user)
            {
                await Navigation.PushAsync(new CallPage(user));
            }
        }
    }
}
