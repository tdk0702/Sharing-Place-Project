using Microsoft.Maui.Controls;
using Microsoft.Maui.Storage;
using CommunityToolkit.Maui.Views;
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using Sharing_Place.Models;
using Plugin.AudioRecorder;
using Sharing_Place.ViewModels;

namespace Sharing_Place.Views
{
    public partial class Message : ContentPage
    {
        private readonly UdpClient udpClient;
        private readonly IPEndPoint remoteEndPoint;
        private readonly string clientId;
        public User chatUser;
        private readonly AudioRecorderService audioRecorderService;
        private List<User> groupMembers;
        private Action<MessagesModel> _addOrUpdateMessageCallback;
        public Message(User user, Action<MessagesModel> addOrUpdateMessageCallback)
        {
            InitializeComponent();
            chatUser = user;
            List<User> members = null;
            udpClient = new UdpClient();
            remoteEndPoint = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 7070);
            _addOrUpdateMessageCallback = addOrUpdateMessageCallback;
            clientId = user.Id;

            Task.Run(ReceiveMessagesAsync);
            if (members != null)
            {
                groupMembers = members;
                Title = "Group Chat";
                DisplayGroupInfo();
            }
            else
            {
                Title = user.Username;
                DisplayUserInfo(user);
            }
            audioRecorderService = new AudioRecorderService
            {
                StopRecordingOnSilence = true, // Dừng ghi âm khi không có tiếng động
                TotalAudioTimeout = TimeSpan.FromSeconds(60), // Giới hạn thời gian ghi âm tối đa
                AudioSilenceTimeout = TimeSpan.FromSeconds(2) // Giới hạn thời gian không có tiếng động tối đa
            };
        }
        private void DisplayGroupInfo()
        {
            UserImage.Source = "group_icon.png"; // Thay bằng icon nhóm thích hợp
            UserNameLabel.Text = $"Group ({groupMembers.Count} members)";
            UserStatusLabel.Text = "Active";
        }
        public void DisplayUserInfo(User user)
        {
            
            UserImage.Source = user.ImgAvt; 
            UserNameLabel.Text = user.Username;
            UserStatusLabel.Text = user.IsOnline ? "Online" : "Offline";
        }

        private async void OnSendMessageTapped(object sender, EventArgs e)
        {
            var messageText = MessageEntry.Text;
            var receiverId = clientId;

            if (!string.IsNullOrEmpty(messageText))
            {
                MessageEntry.Text = string.Empty;
                AddMessage(messageText, true);
                var currentTime = DateTime.Now;

                var newMessage = new MessagesModel
                {
                    ImgAvt = chatUser.ImgAvt,
                    Name = chatUser.Username,
                    Message = messageText,
                    SentAt = currentTime.ToString("HH:mm")
                };
                await SendMessageAsync(messageText, receiverId);
            }
        }

        private void AddMessage(string messageText, bool isSentByUser)
        {
            var messageLabel = new Label
            {
                Text = messageText,
                HorizontalOptions = isSentByUser ? LayoutOptions.EndAndExpand : LayoutOptions.StartAndExpand,
                BackgroundColor = isSentByUser ? Colors.LightBlue : Colors.LightGray,
                Padding = new Thickness(10),
                Margin = new Thickness(10, 10, 10, 0),
                HorizontalTextAlignment = TextAlignment.Start,
                VerticalTextAlignment = TextAlignment.Center,
                LineBreakMode = LineBreakMode.WordWrap,
                MaximumWidthRequest = 250
            };

            var timestampLabel = new Label
            {
                Text = DateTime.Now.ToString("h:mm tt"),
                HorizontalOptions = LayoutOptions.End,
                FontSize = 10,
                TextColor = Colors.Gray,
                Margin = new Thickness(0, 0, 0, 5)
            };

            var containerLayout = new StackLayout
            {
                Orientation = StackOrientation.Vertical,
                HorizontalOptions = isSentByUser ? LayoutOptions.EndAndExpand : LayoutOptions.StartAndExpand,
                Children = { messageLabel, timestampLabel }
            };

            MessagesStack.Children.Add(containerLayout);
            MessagesScrollView.ScrollToAsync(0, MessagesStack.Height, true);
        }

        private void AddMedia(string filePath, bool isImage, bool isSentByUser)
        {
            View mediaView;

            if (isImage)
            {
                mediaView = new Image
                {
                    Source = ImageSource.FromFile(filePath),
                    WidthRequest = 200,
                    HeightRequest = 200,
                    Aspect = Aspect.AspectFit
                };
            }
            else if (filePath.EndsWith(".mp3") || filePath.EndsWith(".wav") || filePath.EndsWith(".m4a"))
            {
                mediaView = new MediaElement
                {
                    Source = filePath,
                    WidthRequest = 300,
                    HeightRequest = 60, // Chỉ cần hiển thị thanh điều khiển phát lại
                    ShouldAutoPlay = false,
                    ShouldShowPlaybackControls = true
                };
            }
            else
            {
                mediaView = new MediaElement
                {
                    Source = filePath,
                    WidthRequest = 300,
                    HeightRequest = 200,
                    ShouldAutoPlay = false,
                    ShouldShowPlaybackControls = true
                };
            }
            mediaView.GestureRecognizers.Add(new TapGestureRecognizer
            {
                Command = new Command(async () => await Navigation.PushAsync(new MediaViewPage(filePath, isImage)))
            });
            var timestampLabel = new Label
            {
                Text = DateTime.Now.ToString("h:mm tt"),
                HorizontalOptions = LayoutOptions.End,
                FontSize = 10,
                TextColor = Colors.Gray,
                Margin = new Thickness(0, 0, 0, 5)
            };

            var containerLayout = new StackLayout
            {
                Orientation = StackOrientation.Vertical,
                HorizontalOptions = isSentByUser ? LayoutOptions.EndAndExpand : LayoutOptions.StartAndExpand,
                Children = { mediaView }
            };

            MessagesStack.Children.Add(containerLayout);
            MessagesScrollView.ScrollToAsync(0, MessagesStack.Height, true);
        }

        private void ReceiveMessage(string messageText)
        {
            if (messageText.StartsWith("./emotion"))
            {
                var parts = messageText.Split(' ');
                var senderId = parts[1];
                var emotion = parts[3];
                AddEmotion(senderId, emotion, senderId == clientId);
            }
            else if (messageText.StartsWith("./file"))
            {
                var parts = messageText.Split(' ');
                var fileType = parts[1];
                var filePath = Path.Combine(FileSystem.CacheDirectory, parts[2]);
                AddMedia(filePath, fileType == "image", false);
            }
            else
            {
                AddMessage(messageText, false);
            }
        }

        private void AddEmotion(string senderId, string emotion, bool isSentByUser)
        {
            var emotionLabel = new Label
            {
                Text = emotion,
                HorizontalOptions = isSentByUser ? LayoutOptions.EndAndExpand : LayoutOptions.StartAndExpand,
                Padding = new Thickness(0),  
                Margin = new Thickness(10, 10, 10, 0),
                LineBreakMode = LineBreakMode.NoWrap,  
                FontSize = 30  
            };

            var emotionLayout = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                HorizontalOptions = isSentByUser ? LayoutOptions.EndAndExpand : LayoutOptions.StartAndExpand,
                Children = { emotionLabel }
            };

            MessagesStack.Children.Add(emotionLayout);
            MessagesScrollView.ScrollToAsync(0, MessagesStack.Height, true);
        }

        private async Task SendMessageAsync(string message, string receiverId)
        {
            try
            {
                string messageId = Guid.NewGuid().ToString();
                string formattedMessage;

                if (groupMembers != null)
                {
                    formattedMessage = $"./group_message {clientId} {messageId} {message}";
                }
                else
                {
                    formattedMessage = $"./message {clientId} {receiverId} {messageId} {message}";
                }
                var messageBytes = Encoding.UTF8.GetBytes(formattedMessage);
                await udpClient.SendAsync(messageBytes, messageBytes.Length, remoteEndPoint);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending message: {ex.Message}");
            }
        }

        private async Task ReceiveMessagesAsync()
        {
            using var udpClient = new UdpClient(7070);
            HashSet<string> processedMessageIds = new HashSet<string>();
            while (true)
            {
                try
                {
                    var result = await udpClient.ReceiveAsync();
                    var message = Encoding.UTF8.GetString(result.Buffer);
                    var parts = message.Split(' ', 5);

                    if (parts.Length < 4) continue; // Skip invalid messages

                    var command = parts[0];
                    var senderId = parts[1];
                    var messageId = parts[2];

                    if (processedMessageIds.Contains(messageId)) continue;
                    processedMessageIds.Add(messageId);

                    switch (command)
                    {
                        case "./message":
                            if (parts.Length >= 5)
                            {
                                var messageText = parts[4];
                                MainThread.BeginInvokeOnMainThread(() =>
                                {
                                    AddMessage(messageText, senderId == clientId);
                                });
                            }
                            break;

                        case "./file":
                            if (parts.Length >= 5)
                            {
                                var fileType = parts[3];
                                var fileName = parts[4];
                                var fileSize = long.Parse(parts[5]);
                                await ReceiveFileAsync(udpClient, fileName, fileSize, fileType);
                            }
                            break;

                        case "./voice":
                            if (parts.Length >= 5)
                            {
                                var fileName = parts[3];
                                var fileSize = long.Parse(parts[4]);
                                await ReceiveFileAsync(udpClient, fileName, fileSize, "voice");
                            }
                            break;

                        case "./emotion":
                            if (parts.Length >= 4)
                            {
                                var emotion = parts[3];
                                MainThread.BeginInvokeOnMainThread(() =>
                                {
                                    AddEmotion(senderId, emotion, senderId == clientId);
                                });
                            }
                            break;
                        case "./group_message":
                            if (parts.Length >= 4)
                            {
                                var messageText = parts[3];
                                MainThread.BeginInvokeOnMainThread(() =>
                                {
                                    AddMessage(messageText, senderId == clientId);
                                });
                            }
                            break;
                        default:
                            Console.WriteLine($"Unknown command: {command}");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error receiving message: {ex.Message}");
                }

                if (processedMessageIds.Count > 1000)
                {
                    processedMessageIds.Clear();
                }
            }
        }

        private async Task ReceiveFileAsync(UdpClient udpClient, string fileName, long fileSize, string fileType)
        {
            try
            {
                var filePath = Path.Combine(FileSystem.CacheDirectory, fileName);
                using (var fileStream = File.Create(filePath))
                {
                    long totalBytesReceived = 0;
                    while (totalBytesReceived < fileSize)
                    {
                        var result = await udpClient.ReceiveAsync();
                        await fileStream.WriteAsync(result.Buffer, 0, result.Buffer.Length);
                        totalBytesReceived += result.Buffer.Length;

                        // Update progress
                        double progress = (double)totalBytesReceived / fileSize;
                        Console.WriteLine($"Receive progress: {progress:P2}");
                    }
                }

                Console.WriteLine("File received successfully");
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    AddMedia(filePath, fileType == "picture", false);
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error receiving file: {ex.Message}");
            }
        }

        private void OnEmotionButtonClicked(object sender, EventArgs e)
        {
            EmotionGrid.IsVisible = !EmotionGrid.IsVisible;
        }

        private void OnSendEmotionTapped(object sender, EventArgs e)
        {
            if (sender is Button button)
            {
                var emotion = button.Text;
                SendEmotion(emotion);
                AddEmotion(clientId, emotion, true);
                EmotionGrid.IsVisible = false;
            }
        }

        private async void SendEmotion(string emotion)
        {
            try
            {
                var messageId = Guid.NewGuid().ToString();
                var command = groupMembers != null
            ? $"./group_emotion {clientId} {messageId} {emotion}"
            : $"./emotion {clientId} {messageId} {emotion}";
                var messageBytes = Encoding.UTF8.GetBytes(command);
                await udpClient.SendAsync(messageBytes, messageBytes.Length, remoteEndPoint);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending emotion: {ex.Message}");
            }
        }

        private void OnFileButtonClicked(object sender, EventArgs e)
        {
            FileStack.IsVisible = !FileStack.IsVisible;
        }

        private async void OnSelectFileTapped(object sender, EventArgs e)
        {
            if (sender is Button button)
            {
                var fileType = button.Text.ToLower();
                var options = new PickOptions
                {
                    PickerTitle = "Please select a file",
                    FileTypes = fileType == "picture" ? FilePickerFileType.Images : FilePickerFileType.Videos
                };

                var fileResult = await FilePicker.Default.PickAsync(options);

                if (fileResult != null)
                {
                    var filePath = fileResult.FullPath;
                    var isImage = fileType == "picture";

                    AddMedia(filePath, isImage, true);
                    await SendFileAsync(filePath, fileType);
                    FileStack.IsVisible = false;
                }
            }
        }

        private async Task SendFileAsync(string filePath, string fileType)
        {
            try
            {
                var fileInfo = new FileInfo(filePath);
                if (fileInfo.Length > 100 * 1024 * 1024) // 100MB in bytes
                {
                    await DisplayAlert("Error", "File is too large. Maximum size is 100MB.", "OK");
                    return;
                }

                var fileName = Path.GetFileName(filePath);
                var fileId = Guid.NewGuid().ToString();
                var message = groupMembers != null
        ? $"./group_file {fileType} {fileName} {fileId} {fileInfo.Length}"
        : $"./file {fileType} {fileName} {fileId} {fileInfo.Length}";
                var messageBytes = Encoding.UTF8.GetBytes(message);

                // Send file info
                await udpClient.SendAsync(messageBytes, messageBytes.Length, remoteEndPoint);

                // Send file data in chunks
                using (var fileStream = File.OpenRead(filePath))
                {
                    var buffer = new byte[5120]; // slightly less than UDP packet size limit
                    int bytesRead;
                    long totalBytesSent = 0;
                    while ((bytesRead = await fileStream.ReadAsync(buffer, 0, buffer.Length)) > 0)
                    {
                        await udpClient.SendAsync(buffer, bytesRead, remoteEndPoint);
                        totalBytesSent += bytesRead;

                        // Update progress (you can use this to update a progress bar in the UI)
                        double progress = (double)totalBytesSent / fileInfo.Length;
                        Console.WriteLine($"Send progress: {progress:P2}");
                        await Task.Delay(10);
                    }
                }

                Console.WriteLine("File sent successfully");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending file: {ex.Message}");
                await DisplayAlert("Error", $"Failed to send file: {ex.Message}", "OK");
            }
        }


        private bool isRecording = false;
        private DateTime recordingStartTime;

        private async void OnChatVoiceButtonClicked(object sender, EventArgs e)
        {
            try
            {
                var status = await Permissions.RequestAsync<Permissions.Microphone>();
                if (status != PermissionStatus.Granted)
                {
                    await DisplayAlert("Lỗi", "Cần quyền truy cập microphone để ghi âm", "OK");
                    return;
                }
                RecordingStack.IsVisible = !RecordingStack.IsVisible;
                if (isRecording)
                {
                    await StopRecordingAndSendAsync();
                }
                else
                {
                    await StartRecordingAsync();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in voice message handling: {ex.Message}");
                await DisplayAlert("Error", $"Failed to handle voice message: {ex.Message}", "OK");
            }
        }

        private async Task StartRecordingAsync()
        {
            isRecording = true;
            RecordingProgressBar.IsVisible = true;
            RecordingTimeLabel.IsVisible = true;
            StopRecordingButton.IsVisible = true;

            recordingStartTime = DateTime.Now;
            Device.StartTimer(TimeSpan.FromSeconds(1), () =>
            {
                if (!isRecording) return false;
                var elapsed = DateTime.Now - recordingStartTime;
                RecordingTimeLabel.Text = elapsed.ToString(@"mm\:ss");
                RecordingProgressBar.Progress = elapsed.TotalSeconds / 60.0; // Giả sử giới hạn ghi âm là 60 giây
                return true;
            });

            await audioRecorderService.StartRecording();
        }

        private async Task StopRecordingAndSendAsync()
        {
            isRecording = false;
            await audioRecorderService.StopRecording();
            var audioFilePath = audioRecorderService.GetAudioFilePath();

            if (File.Exists(audioFilePath))
            {
                var receiverId = "ReceiverClientId";
                await SendVoiceAsync(audioFilePath, receiverId);

                // Hiển thị tin nhắn giọng nói trong giao diện người dùng
                AddMedia(audioFilePath, false, true);
            }

            RecordingProgressBar.IsVisible = false;
            RecordingTimeLabel.IsVisible = false;
            StopRecordingButton.IsVisible = false;
        }

        private async void OnStopRecordingButtonClicked(object sender, EventArgs e)
        {
            await StopRecordingAndSendAsync();
        }

        private async Task SendVoiceAsync(string filePath, string receiverId)
        {
            try
            {
                var fileInfo = new FileInfo(filePath);
                if (fileInfo.Length > 100 * 1024 * 1024) // 100MB in bytes
                {
                    await DisplayAlert("Error", "File is too large. Maximum size is 100MB.", "OK");
                    return;
                }

                var fileName = Path.GetFileName(filePath);
                var message = $"./voice {clientId} {receiverId} {fileName} {fileInfo.Length}";
                var messageBytes = Encoding.UTF8.GetBytes(message);

                // Gửi thông tin tệp
                await udpClient.SendAsync(messageBytes, messageBytes.Length, remoteEndPoint);

                // Gửi dữ liệu tệp theo từng phần
                using (var fileStream = File.OpenRead(filePath))
                {
                    var buffer = new byte[10000]; // Giới hạn kích thước gói UDP
                    int bytesRead;
                    long totalBytesSent = 0;
                    while ((bytesRead = await fileStream.ReadAsync(buffer, 0, buffer.Length)) > 0)
                    {
                        await udpClient.SendAsync(buffer, bytesRead, remoteEndPoint);
                        totalBytesSent += bytesRead;

                        // Cập nhật tiến độ 
                        double progress = (double)totalBytesSent / fileInfo.Length;
                        Console.WriteLine($"Send progress: {progress:P2}");
                        await Task.Delay(10);
                    }
                }

                Console.WriteLine("File sent successfully");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending file: {ex.Message}");
                await DisplayAlert("Error", $"Failed to send file: {ex.Message}", "OK");
            }
        }
    }
}