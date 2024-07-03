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
            View mediaView;
            if (isImage)
            {
                mediaView = new Image
                {
                    Source = ImageSource.FromFile(mediaPath),
                    Aspect = Aspect.AspectFit,
                    WidthRequest = 300,
                    HeightRequest = 300
                };
            }
            else
            {
                mediaView = new MediaElement
                {
                    Source = mediaPath,
                    Aspect = Aspect.AspectFit,
                    WidthRequest = 300,
                    HeightRequest = 300,
                    ShouldAutoPlay = false,
                    ShouldShowPlaybackControls = true
                };
            }

            MediaContainer.Children.Add(mediaView);
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
            await Navigation.PopAsync(); // Quay lại trang trước đó
        }
    }
}
