﻿using Sharing_Place.Models;
using Sharing_Place.ViewModels;
namespace Sharing_Place.Views.RoomViews;

public partial class ListRoom : ContentPage
{
    public List<RoomsModel> Rooms;
	public ListRoom()
	{
		InitializeComponent();
        /*if (ServerConnect.isConnected) loadRooms();
        else*/ loadRoomEx();
	}

    protected override void OnAppearing()
    {
        base.OnAppearing();
        lvData.ItemsSource = Rooms;
    }
    private void loadRooms()
    {
        string command = string.Format("./loadview {0} rooms", ServerConnect.Id);
        string data = ServerConnect.getData(command);
        if (data.Contains("[EMPTY]")) return;
        string[] dtsplit = data.Split(";");
        for(int i = 0; i < dtsplit.Length; i++)
        {
            RoomsModel room = new RoomsModel() { 
                Id = dtsplit[i].Split(" ")[0], 
                Name = dtsplit[i].Split(" ")[2].Replace("_"," "),
                type = dtsplit[i].Split(" ")[3]
            };
            Rooms.Add(room);
        }
    }
    private void loadRoomEx()
    {
        Rooms = new List<RoomsModel>() {
            new RoomsModel(){ Id="0", Name="Phòng Việt Nam", Img="logo", type="private"},
            new RoomsModel(){ Id="1", Name="Sharing Place Test", Img="logo", type="private"},
            new RoomsModel(){ Id="2", Name="Vn nhào vô!", Img="logo", type="private"},
            new RoomsModel(){ Id="3", Name="Phòng dành cho newbie", Img="logo", type="private"},
            new RoomsModel(){ Id="4", Name="Vui là chính!", Img="logo", type="private"},
            new RoomsModel(){ Id="5", Name="Chủ phòng vui vẻ lắm", Img="logo", type="private"},
            new RoomsModel(){ Id="6", Name="Room7", Img="logo", type="private"},
            new RoomsModel(){ Id="7", Name="Room8", Img="logo", type="private"},
            new RoomsModel(){ Id="8", Name="Room9", Img="logo", type="private"},
            new RoomsModel(){ Id="9", Name="Room10", Img="logo", type="private"}
        };
    }

    private void lvData_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        lvData.SelectedItem = null;
    }

    private void lvData_ItemSelected(object sender, SelectedItemChangedEventArgs e)
    {
        if (lvData.SelectedItem == null)
        {
            string id = ((RoomsModel)lvData.SelectedItem).Id;
            Navigation.PushAsync(new RoomPost(id));
        }
    }

    private async void AddRoomCommand(object sender, EventArgs e)
    {
        await DisplayAlert("", "Add Room", "OK");
    }
}