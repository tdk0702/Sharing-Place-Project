using Microsoft.Maui.Controls;

namespace Sharing_Place.Views;

public partial class PostDetail : ContentPage
{
    int count = 0;

    public PostDetail()
    {
        InitializeComponent();
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
}