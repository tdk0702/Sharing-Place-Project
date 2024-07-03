using Sharing_Place.ViewModels;
namespace Sharing_Place.Views.RoomViews;

public partial class RoomPost : ContentPage
{
    string Id;
	public RoomPost()
	{
		InitializeComponent();
	}

    public RoomPost(string id)
    {
		InitializeComponent();
        Id = id;
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

    }
}