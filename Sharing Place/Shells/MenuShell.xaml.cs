using Sharing_Place.Views;
using Sharing_Place.Views.RoomViews;
using Sharing_Place.Models;
namespace Sharing_Place.Shells;

public partial class MenuShell : Shell
{
    public static Dictionary<string, string> Friends = new Dictionary<string, string>();
    public static Dictionary<string, string> ChatPerson = new Dictionary<string, string>();
	public MenuShell()
	{
		InitializeComponent();
        RegisterRoutes();
        //loadData();
    }
    private static void RegisterRoutes()
    {
        Routing.RegisterRoute(nameof(Message), typeof(Message));
        Routing.RegisterRoute(nameof(PostMenu), typeof(PostMenu));
        Routing.RegisterRoute(nameof(SettingInfo), typeof(SettingInfo));
        Routing.RegisterRoute(nameof(SettingMessage), typeof(SettingMessage));
        Routing.RegisterRoute(nameof(ListFriend), typeof(ListFriend));
        Routing.RegisterRoute(nameof(Friends), typeof(Friends));
        Routing.RegisterRoute(nameof(ListMessage), typeof(ListMessage));
        Routing.RegisterRoute(nameof(ListRoom), typeof(ListRoom));
    }
}