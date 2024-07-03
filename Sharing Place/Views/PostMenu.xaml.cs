namespace Sharing_Place.Views;

public partial class PostMenu : ContentPage
{
	public PostMenu()
	{
        InitializeComponent();
	}
    private async void OnFrameTapped(object sender, EventArgs e)
    {
        // Navigate to the MainPage
        await Navigation.PushAsync(new Sharing_Place.Page());
    }
    private async void OnNewPostsClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new NewPostPage());
    }
}