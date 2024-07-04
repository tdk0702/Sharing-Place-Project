using Microsoft.Maui.Controls;
using Microsoft.Maui.Storage;
using Sharing_Place.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace Sharing_Place.Views
{
    public partial class NewPostPage : ContentPage
    {
        public event EventHandler<Post> PostCompleted;
        private string _mediaFilePath;

        public NewPostPage()
        {
            InitializeComponent();
        }

        private async void OnSelectFileButtonClicked(object sender, EventArgs e)
        {
            var result = await PickAndShowFileAsync();
            if (result != null)
            {
                _mediaFilePath = result.FullPath;
                selectedFileLabel.Text = result.FileName;
            }
        }

        private async Task<FileResult> PickAndShowFileAsync()
        {
            try
            {
                var result = await FilePicker.PickAsync(new PickOptions
                {
                    FileTypes = new FilePickerFileType(
                        new Dictionary<DevicePlatform, IEnumerable<string>>
                        {
                            { DevicePlatform.Android, new[] { "image/*", "video/*" } },
                            { DevicePlatform.iOS, new[] { "public.image", "public.movie" } },
                            { DevicePlatform.MacCatalyst, new[] { "public.image", "public.movie" } },
                            { DevicePlatform.WinUI, new[] { ".jpg", ".jpeg", ".png", ".bmp", ".mp4", ".mov", ".avi" } },
                            { DevicePlatform.Tizen, new[] { "image/*", "video/*" } },
                        }),
                    PickerTitle = "Please select an image or video file"
                });

                if (result != null)
                {
                    return result;
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
            }

            return null;
        }

        private async void OnPostButtonClicked(object sender, EventArgs e)
        {
            var newPost = new Post
            {
                UserName = "John Doe", // Replace with actual user data
                Body = postBodyEditor.Text,
                TimeAgo = "Just now",
                MediaFilePath = _mediaFilePath
            };

            PostCompleted?.Invoke(this, newPost);

            await Navigation.PopAsync();
        }
    }

public class Post
    {
        public string UserName { get; set; }
        public string Body { get; set; }
        public string TimeAgo { get; set; }
        public string MediaFilePath { get; set; }
    }
}