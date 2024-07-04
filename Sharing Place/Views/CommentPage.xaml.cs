using Microsoft.Maui.Controls;
using Sharing_Place.Models;
using System;
using System.Collections.ObjectModel;
using System.Linq;

namespace Sharing_Place
{
    public partial class CommentPage : ContentPage
    {
        private ObservableCollection<Comment> Comments { get; set; }
        private int PostId { get; set; } // Add a property to store the current post ID

        public CommentPage(int postId)
        {
            InitializeComponent();
            PostId = postId; // Initialize the post ID
            LoadComments();
        }

        private void LoadComments()
        {
            // Replace this with actual database retrieval logic based on PostId
            Comments = new ObservableCollection<Comment>
            {
                new Comment { UserName = "Jane Doe", Body = "This is a sample comment." },
                new Comment { UserName = "John Smith", Body = "Another comment here." }
            };

            commentsListView.ItemsSource = Comments;
        }

        private void PostComment_Clicked(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(commentEntry.Text))
            {
                var newComment = new Comment
                {
                    UserName = "You", // Replace with actual user data
                    Body = commentEntry.Text
                };

                Comments.Add(newComment); // Add the new comment to the collection
                commentEntry.Text = string.Empty;
            }
        }
    }
    public class Comment
    {
        public string UserName { get; set; }
        public string Body { get; set; }
        
    }
}