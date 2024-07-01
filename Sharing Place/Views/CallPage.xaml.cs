using Microsoft.Maui.Controls;
using Plugin.Maui.Audio;
using System;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Essentials;

namespace Sharing_Place.Views
{
    public partial class CallPage : ContentPage, INotifyPropertyChanged
    {
        private bool _isConnecting;
        private bool _isInCall;
        private bool _isIncomingCall;
        private TimeSpan _callDuration;
        private User1 _callingUser;
        private DateTime _callStartTime;
        private bool _isMuted;
        private bool _isSpeakerOn;

        public bool IsMuted
        {
            get => _isMuted;
            set
            {
                _isMuted = value;
                OnPropertyChanged(nameof(IsMuted));
            }
        }

        public bool IsSpeakerOn
        {
            get => _isSpeakerOn;
            set
            {
                _isSpeakerOn = value;
                OnPropertyChanged(nameof(IsSpeakerOn));
            }
        }

        public bool IsConnecting
        {
            get => _isConnecting;
            set
            {
                _isConnecting = value;
                OnPropertyChanged(nameof(IsConnecting));
            }
        }

        public bool IsInCall
        {
            get => _isInCall;
            set
            {
                _isInCall = value;
                OnPropertyChanged(nameof(IsInCall));
            }
        }

        public bool IsIncomingCall
        {
            get => _isIncomingCall;
            set
            {
                _isIncomingCall = value;
                OnPropertyChanged(nameof(IsIncomingCall));
            }
        }

        public TimeSpan CallDuration
        {
            get => _callDuration;
            set
            {
                _callDuration = value;
                OnPropertyChanged(nameof(CallDuration));
            }
        }

        public ICommand CancelCommand { get; }
        public ICommand EndCallCommand { get; }
        public ICommand MuteCommand { get; }
        public ICommand SpeakerCommand { get; }
        public ICommand AcceptCallCommand { get; }
        public ICommand RejectCallCommand { get; }

        public CallPage(User1 user)
        {
            InitializeComponent();
            _callingUser = user;
            BindingContext = this;

            IsConnecting = true;
            IsInCall = false;
            IsIncomingCall = false;
            CallDuration = TimeSpan.Zero;
            IsMuted = false;
            IsSpeakerOn = false;

            CancelCommand = new Command(OnCancel);
            EndCallCommand = new Command(OnEndCall);
            MuteCommand = new Command(OnMute);
            SpeakerCommand = new Command(OnSpeaker);
            AcceptCallCommand = new Command(OnAcceptCall);
            RejectCallCommand = new Command(OnRejectCall);

            Device.StartTimer(TimeSpan.FromSeconds(3), () =>
            {
                IsConnecting = false;
                IsInCall = true;
                _callStartTime = DateTime.Now;
                Device.StartTimer(TimeSpan.FromSeconds(1), UpdateCallDuration);
                return false;
            });
        }

        private void OnCancel()
        {
            Navigation.PopAsync();
        }

        private void OnEndCall()
        {
            IsInCall = false;
            Navigation.PopAsync();
        }

        private void OnMute()
        {
            IsMuted = !IsMuted;
            // Logic để tắt/bật tiếng
            var volume = IsMuted ? 0 : 1;
           // AudioManager.Volume = volume;
        }

        private void OnSpeaker()
        {
            IsSpeakerOn = !IsSpeakerOn;
            // Logic để bật/tắt loa ngoài
            //AudioManager.Equals = IsSpeakerOn;
        }

        private void OnAcceptCall()
        {
            IsIncomingCall = false;
            IsInCall = true;
            _callStartTime = DateTime.Now;
            Device.StartTimer(TimeSpan.FromSeconds(1), UpdateCallDuration);
        }

        private void OnRejectCall()
        {
            IsIncomingCall = false;
            Navigation.PopAsync();
        }

        private bool UpdateCallDuration()
        {
            if (IsInCall)
            {
                CallDuration = DateTime.Now - _callStartTime;
                return true;
            }
            return false;
        }

        public new event PropertyChangedEventHandler PropertyChanged;
        protected new void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
