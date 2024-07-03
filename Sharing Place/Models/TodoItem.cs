﻿namespace Sharing_Place.Models;

public class TodoItems
{
    public string Title { get; set; }

    public bool IsCompleted { get; set; }

    public DateTime CreateDate { get; set; }

    public DateTime? CompleteDate { get; set; }
}