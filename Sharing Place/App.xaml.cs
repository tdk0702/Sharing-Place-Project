using Sharing_Place.Views;
using Sharing_Place.Shells;
using System.Text;

namespace Sharing_Place
{
    public partial class App : Application
    {
        //public static IPEndPoint Server;
        public App()
        {
            InitializeComponent();
            MainPage = new LoginShell();
        }
    }
}
