namespace Sharing_Place.Views;

public partial class NewPostPage : ContentPage
{
	public NewPostPage()
	{
		InitializeComponent();
	}
    private async void OnPostButtonClicked(object sender, EventArgs e)
    {
        // Handle the post logic here

        // Navigate back to the post menu or main page
        await Navigation.PopAsync();
    }
}