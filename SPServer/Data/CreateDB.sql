/*DECLARE @sql NVARCHAR(max)=''

SELECT @sql += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql
GO
*/
CREATE SCHEMA [User]
GO

CREATE SCHEMA [Post]
GO

CREATE SCHEMA [Room]
GO

CREATE SCHEMA [Group]
GO

CREATE TABLE [Images] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [link] nvarchar(255) DEFAULT 'link',
  [user_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Musics] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [link] nvarchar(255) DEFAULT 'link',
  [title] ntext,
  [info] ntext,
  [user_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

--DROP TABLE [User].[Users]
--GO



CREATE TABLE [User].[Users] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [username] nvarchar(255) NOT NULL,
  [password] nvarchar(255) NOT NULL,
  [email] NVARCHAR(255) NOT NULL ,--CHECK ([email] LIKE '%@%' AND [email] LIKE '%.%'),
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

--ALTER TABLE [User].[Users] DROP CK__Users__email__3E52440B;

CREATE TABLE [User].[Info] (
  [_id] int PRIMARY KEY,
  [fullname] nvarchar(255) NOT NULL,
  [avatar] int,
  [nickname] nvarchar(255),
  [gender] nvarchar(6) NOT NULL CHECK ([gender] IN ('male', 'female', 'other')) DEFAULT 'male',
  [date_of_birth] DATE,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [User].[Followers] (
  [following_id] int,
  [followed_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([followed_id], [following_id])
)
GO

CREATE TABLE [User].[Friends] (
  [user_id] int,
  [friend_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([user_id], [friend_id])
)
GO

CREATE TABLE [User].[Messages] (
  [user1_id] int,
  [user2_id] int,
  [body] ntext,
  [img] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Post].[Posts] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [user_id] int,
  [title] ntext,
  [body] ntext,
  [status] nvarchar(8) NOT NULL CHECK ([status] IN ('private', 'public', 'friendly')) DEFAULT 'private',
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Post].[Comments] (
  [post_id] int,
  [user_id] int,
  [body] ntext,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([post_id], [user_id])
)
GO

CREATE TABLE [Post].[Emotions] (
  [post_id] int,
  [user_id] int,
  [type] nvarchar(7) CHECK ([type] IN ('', 'Like', 'Love', 'Haha', 'Dislike', 'Haste')) DEFAULT (''),
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([post_id], [user_id])
)
GO

CREATE TABLE [Post].[Share] (
  [post_id] int,
  [user_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Room].[Rooms] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [user_id] int,
  [roomname] nvarchar(255),
  [description] ntext,
  [type] nvarchar(7) NOT NULL CHECK ([type] IN ('public', 'private')) DEFAULT 'private',
  [created_at] DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE [Room].[Members] (
  [room_id] int NOT NULL,
  [user_id] int NOT NULL,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([room_id], [user_id])
)
GO

CREATE TABLE [Room].[Messages] (
  [room_id] int NOT NULL,
  [user_id] int NOT NULL,
  [body] ntext,
  [img] int,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([room_id], [user_id])
)
GO

CREATE TABLE [Room].[Posts] (
  [room_id] int NOT NULL,
  [post_id] int NOT NULL,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([room_id], [post_id])
)
GO

CREATE TABLE [Room].[Events] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [room_id] int,
  [user_id] int,
  [songs] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Group].[Groups] (
  [id] int PRIMARY KEY IDENTITY(0, 1),
  [group_name] nvarchar(255) NOT NULL,
  [group_avatar] int,
  [created_at] DATETIME DEFAULT GETDATE(),
)
GO

CREATE TABLE [Group].[Member] (
  [group_id] int,
  [user_id] int,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([group_id], [user_id])
)
GO

/*DROP TABLE [Group].[Member];
GO*/

CREATE TABLE [Group].[Messages] (
  [group_id] int,
  [user_id] int,
  [body] ntext,
  [img] int,
  [created_at] DATETIME DEFAULT GETDATE(),
  PRIMARY KEY ([group_id], [user_id])
)
GO

/*EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Content of the post',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Posts',
@level2type = N'Column', @level2name = 'body';
GO*/

ALTER TABLE [Images] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Musics] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Followers] ADD FOREIGN KEY ([following_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Followers] ADD FOREIGN KEY ([followed_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Friends] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Friends] ADD FOREIGN KEY ([friend_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Info] ADD FOREIGN KEY ([_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Info] ADD FOREIGN KEY ([avatar]) REFERENCES [Images] ([id])
GO

ALTER TABLE [Group].[Member] ADD FOREIGN KEY ([group_id]) REFERENCES [Group].[Groups] ([id])
GO

ALTER TABLE [Group].[Member] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Group].[Messages] ADD FOREIGN KEY ([group_id]) REFERENCES [Group].[Groups] ([id])
GO

ALTER TABLE [Group].[Messages] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Group].[Messages] ADD FOREIGN KEY ([img]) REFERENCES [Images] ([id])
GO

ALTER TABLE [User].[Messages] ADD FOREIGN KEY ([user1_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Messages] ADD FOREIGN KEY ([user2_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [User].[Messages] ADD FOREIGN KEY ([img]) REFERENCES [Images] ([id])
GO

ALTER TABLE [Post].[Posts] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Post].[Comments] ADD FOREIGN KEY ([post_id]) REFERENCES [Post].[Posts] ([id])
GO

ALTER TABLE [Post].[Comments] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Post].[Emotions] ADD FOREIGN KEY ([post_id]) REFERENCES [Post].[Posts] ([id])
GO

ALTER TABLE [Post].[Emotions] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Post].[Share] ADD FOREIGN KEY ([post_id]) REFERENCES [Post].[Posts] ([id])
GO

ALTER TABLE [Post].[Share] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Room].[Rooms] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Room].[Members] ADD FOREIGN KEY ([room_id]) REFERENCES [Room].[Rooms] ([id])
GO

ALTER TABLE [Room].[Members] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Room].[Messages] ADD FOREIGN KEY ([room_id]) REFERENCES [Room].[Rooms] ([id])
GO

ALTER TABLE [Room].[Messages] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Room].[Messages] ADD FOREIGN KEY ([img]) REFERENCES [Images] ([id])
GO

ALTER TABLE [Room].[Posts] ADD FOREIGN KEY ([room_id]) REFERENCES [Room].[Rooms] ([id])
GO

ALTER TABLE [Room].[Posts] ADD FOREIGN KEY ([post_id]) REFERENCES [Post].[Posts] ([id])
GO

ALTER TABLE [Room].[Events] ADD FOREIGN KEY ([room_id]) REFERENCES [Room].[Rooms] ([id])
GO

ALTER TABLE [Room].[Events] ADD FOREIGN KEY ([user_id]) REFERENCES [User].[Users] ([id])
GO

ALTER TABLE [Room].[Events] ADD FOREIGN KEY ([songs]) REFERENCES [Musics] ([id])
GO


/*SELECT password FROM [User].[Users] WHERE username = N'dokyuhi';
GO
INSERT INTO [User].[Info] VALUES(1, N'Trương Duy Khôi', NULL, NULL ,DEFAULT, NULL, DEFAULT);
GO*/

--INSERT INTO [Room].[Rooms] VALUES();
INSERT INTO [User].[Users] VALUES ('dokyuhi', 'dkduykhoi@gmail.com', '$HASH|V1$10000$ZvX2KuyYxpSdiv3q7jIt/bN5VAzUcd0ZdQ5fZmi3Z6nhNphU', DEFAULT);
GO
INSERT INTO [User].[Info] VALUES(2,N'Trương Duy Khôi', NULL, NULL, DEFAULT, NULL, DEFAULT);
GO
SELECT * FROM [User].[Users];
INSERT INTO [User].[Users] VALUES ('tdk0702', '22520702@gm.uit.edu.vn', '$HASH|V1$10000$3Fp/Hx2AF9vgA/UI9KSeLlisVVYYXYfEMvMzO4krCTEGNu/u', DEFAULT);