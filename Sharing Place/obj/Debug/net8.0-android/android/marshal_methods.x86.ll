; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [363 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [720 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 14013194, ; 2: Plugin.AudioRecorder.dll => 0xd5d30a => 205
	i32 15721112, ; 3: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 4: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 270
	i32 34715100, ; 5: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 307
	i32 34839235, ; 6: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39485524, ; 7: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 8: System.Threading.Thread => 0x28aa24d => 145
	i32 57725457, ; 9: it\Microsoft.Data.SqlClient.resources => 0x370d211 => 318
	i32 57727992, ; 10: ja\Microsoft.Data.SqlClient.resources => 0x370dbf8 => 319
	i32 66541672, ; 11: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 12: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 358
	i32 68219467, ; 13: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 14: Microsoft.Maui.Graphics.dll => 0x44bb714 => 203
	i32 82292897, ; 15: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 16: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 289
	i32 117431740, ; 17: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 18: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 289
	i32 122350210, ; 19: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 20: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 311
	i32 139659294, ; 21: ja/Microsoft.Data.SqlClient.resources.dll => 0x853081e => 319
	i32 142721839, ; 22: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149972175, ; 23: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 24: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 25: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 244
	i32 166535111, ; 26: ru/Microsoft.Data.SqlClient.resources.dll => 0x9ed1fc7 => 322
	i32 176265551, ; 27: System.ServiceProcess => 0xa81994f => 132
	i32 177853112, ; 28: Sharing Place.dll => 0xa99d2b8 => 0
	i32 182336117, ; 29: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 291
	i32 184328833, ; 30: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 31: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 355
	i32 199333315, ; 32: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 356
	i32 205061960, ; 33: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 34: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 242
	i32 220171995, ; 35: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 36: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 264
	i32 230752869, ; 37: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 38: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 39: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 40: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 41: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 247
	i32 264223668, ; 42: zh-Hans\Microsoft.Data.SqlClient.resources => 0xfbfbbb4 => 323
	i32 266337479, ; 43: Xamarin.Google.Guava.FailureAccess.dll => 0xfdffcc7 => 306
	i32 276479776, ; 44: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 45: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 266
	i32 280482487, ; 46: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 263
	i32 280992041, ; 47: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 327
	i32 291076382, ; 48: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 293579439, ; 49: ExoPlayer.Dash.dll => 0x117faaaf => 218
	i32 298918909, ; 50: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 51: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 355
	i32 318968648, ; 52: Xamarin.AndroidX.Activity.dll => 0x13031348 => 233
	i32 321597661, ; 53: System.Numerics => 0x132b30dd => 83
	i32 330147069, ; 54: Microsoft.SqlServer.Server => 0x13ada4fd => 204
	i32 336156722, ; 55: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 340
	i32 342366114, ; 56: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 265
	i32 356389973, ; 57: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 339
	i32 360082299, ; 58: System.ServiceModel.Web => 0x15766b7b => 131
	i32 367216257, ; 59: Plugin.AudioRecorder => 0x15e34681 => 205
	i32 367780167, ; 60: System.IO.Pipes => 0x15ebe147 => 55
	i32 374914964, ; 61: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 62: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 63: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 64: System.Memory.dll => 0x16fe439a => 62
	i32 392610295, ; 65: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 395744057, ; 66: _Microsoft.Android.Resource.Designer => 0x17969339 => 359
	i32 403441872, ; 67: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 68: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 351
	i32 441335492, ; 69: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 248
	i32 442565967, ; 70: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 71: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 261
	i32 451504562, ; 72: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 452127346, ; 73: ExoPlayer.Database.dll => 0x1af2ea72 => 219
	i32 456227837, ; 74: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 75: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465846621, ; 76: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 77: System.dll => 0x1bff388e => 164
	i32 476646585, ; 78: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 263
	i32 485463106, ; 79: Microsoft.IdentityModel.Abstractions => 0x1cef9442 => 192
	i32 486930444, ; 80: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 276
	i32 498788369, ; 81: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 82: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 338
	i32 503918385, ; 83: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 332
	i32 513247710, ; 84: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 189
	i32 526420162, ; 85: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 86: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 311
	i32 530272170, ; 87: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 88: Microsoft.Extensions.Logging => 0x20216150 => 185
	i32 540030774, ; 89: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 90: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 91: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 548916678, ; 92: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 179
	i32 549171840, ; 93: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 94: Jsr305Binding => 0x213954e7 => 302
	i32 569601784, ; 95: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 300
	i32 577335427, ; 96: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 97: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 346
	i32 597488923, ; 98: CommunityToolkit.Maui => 0x239cf51b => 175
	i32 601371474, ; 99: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 100: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 613668793, ; 101: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 626887733, ; 102: ExoPlayer.Container => 0x255d8c35 => 216
	i32 627609679, ; 103: Xamarin.AndroidX.CustomView => 0x2568904f => 253
	i32 627931235, ; 104: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 344
	i32 639843206, ; 105: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 259
	i32 643868501, ; 106: System.Net => 0x2660a755 => 81
	i32 662205335, ; 107: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 108: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 296
	i32 666292255, ; 109: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 240
	i32 672442732, ; 110: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 111: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 112: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 326
	i32 690569205, ; 113: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 114: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 313
	i32 693804605, ; 115: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 116: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 117: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 308
	i32 700358131, ; 118: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 119: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 341
	i32 709557578, ; 120: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 329
	i32 720511267, ; 121: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 312
	i32 722857257, ; 122: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 723796036, ; 123: System.ClientModel.dll => 0x2b244044 => 207
	i32 735137430, ; 124: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 752232764, ; 125: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 126: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 230
	i32 759454413, ; 127: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 128: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 129: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 130: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 350
	i32 789151979, ; 131: Microsoft.Extensions.Options => 0x2f0980eb => 188
	i32 790371945, ; 132: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 254
	i32 804715423, ; 133: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 134: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 268
	i32 812693636, ; 135: ExoPlayer.Dash => 0x3070b884 => 218
	i32 823281589, ; 136: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 137: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 138: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 139: System.Net.Quic => 0x31b69d60 => 71
	i32 843511501, ; 140: Xamarin.AndroidX.Print => 0x3246f6cd => 282
	i32 873119928, ; 141: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 142: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 143: System.Net.Http.Json => 0x3463c971 => 63
	i32 904024072, ; 144: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 145: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 915551335, ; 146: ExoPlayer.Ext.MediaSession => 0x36923467 => 224
	i32 926902833, ; 147: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 353
	i32 928116545, ; 148: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 307
	i32 939704684, ; 149: ExoPlayer.Extractor => 0x3802c16c => 222
	i32 952186615, ; 150: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 956575887, ; 151: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 312
	i32 966729478, ; 152: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 303
	i32 967690846, ; 153: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 265
	i32 975236339, ; 154: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 155: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 156: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 157: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 158: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 159: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 160: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 161: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 286
	i32 1019214401, ; 162: System.Drawing => 0x3cbffa41 => 36
	i32 1028013380, ; 163: ExoPlayer.UI.dll => 0x3d463d44 => 228
	i32 1028951442, ; 164: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 184
	i32 1029334545, ; 165: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 328
	i32 1031528504, ; 166: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 304
	i32 1035644815, ; 167: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 238
	i32 1036536393, ; 168: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 169: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1048439329, ; 170: de/Microsoft.Data.SqlClient.resources.dll => 0x3e7dea21 => 315
	i32 1052210849, ; 171: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 272
	i32 1062017875, ; 172: Microsoft.Identity.Client.Extensions.Msal => 0x3f4d1b53 => 191
	i32 1067306892, ; 173: GoogleGson => 0x3f9dcf8c => 178
	i32 1082857460, ; 174: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 175: Xamarin.Kotlin.StdLib => 0x409e66d8 => 309
	i32 1089913930, ; 176: System.Diagnostics.EventLog.dll => 0x40f6c44a => 209
	i32 1098259244, ; 177: System => 0x41761b2c => 164
	i32 1118262833, ; 178: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 341
	i32 1121599056, ; 179: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 271
	i32 1127624469, ; 180: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 187
	i32 1138436374, ; 181: Microsoft.Data.SqlClient.dll => 0x43db2916 => 180
	i32 1149092582, ; 182: Xamarin.AndroidX.Window => 0x447dc2e6 => 299
	i32 1151313727, ; 183: ExoPlayer.Rtsp => 0x449fa73f => 225
	i32 1168523401, ; 184: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 347
	i32 1170634674, ; 185: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 186: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 295
	i32 1178241025, ; 187: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 280
	i32 1203215381, ; 188: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 345
	i32 1204270330, ; 189: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 240
	i32 1208641965, ; 190: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1219128291, ; 191: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 192: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 343
	i32 1243150071, ; 193: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 300
	i32 1253011324, ; 194: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 195: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 327
	i32 1263886435, ; 196: Xamarin.Google.Guava.dll => 0x4b556063 => 305
	i32 1264511973, ; 197: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 290
	i32 1267360935, ; 198: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 294
	i32 1273260888, ; 199: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 245
	i32 1275534314, ; 200: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 313
	i32 1278448581, ; 201: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 237
	i32 1293217323, ; 202: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 256
	i32 1309188875, ; 203: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1309209905, ; 204: ExoPlayer.DataSource => 0x4e08f531 => 220
	i32 1322716291, ; 205: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 299
	i32 1324164729, ; 206: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 207: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1347751866, ; 208: Plugin.Maui.Audio => 0x50550fba => 206
	i32 1364015309, ; 209: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 210: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 357
	i32 1376866003, ; 211: Xamarin.AndroidX.SavedState => 0x52114ed3 => 286
	i32 1379779777, ; 212: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1395857551, ; 213: Xamarin.AndroidX.Media.dll => 0x5333188f => 277
	i32 1402170036, ; 214: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 215: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 249
	i32 1406299041, ; 216: Xamarin.Google.Guava.FailureAccess => 0x53d26ba1 => 306
	i32 1408764838, ; 217: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 218: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 219: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1430672901, ; 220: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 325
	i32 1434145427, ; 221: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 222: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 303
	i32 1439761251, ; 223: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1452070440, ; 224: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 225: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 226: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 227: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1460893475, ; 228: System.IdentityModel.Tokens.Jwt => 0x57137723 => 210
	i32 1461004990, ; 229: es\Microsoft.Maui.Controls.resources => 0x57152abe => 331
	i32 1461234159, ; 230: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 231: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 232: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 233: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 239
	i32 1470490898, ; 234: Microsoft.Extensions.Primitives => 0x57a5e912 => 189
	i32 1479771757, ; 235: System.Collections.Immutable => 0x5833866d => 9
	i32 1480156764, ; 236: ExoPlayer.DataSource.dll => 0x5839665c => 220
	i32 1480492111, ; 237: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 238: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 239: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 287
	i32 1493001747, ; 240: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 335
	i32 1498168481, ; 241: Microsoft.IdentityModel.JsonWebTokens.dll => 0x594c3ca1 => 193
	i32 1514721132, ; 242: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 330
	i32 1536373174, ; 243: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 244: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 245: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 246: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 247: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 350
	i32 1565310744, ; 248: System.Runtime.Caching => 0x5d4cbf18 => 212
	i32 1565862583, ; 249: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 250: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 251: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 252: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582305585, ; 253: Azure.Identity => 0x5e501131 => 174
	i32 1582372066, ; 254: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 255
	i32 1592978981, ; 255: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1596263029, ; 256: zh-Hant\Microsoft.Data.SqlClient.resources => 0x5f250a75 => 324
	i32 1597949149, ; 257: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 304
	i32 1601112923, ; 258: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1604827217, ; 259: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 260: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 261: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 275
	i32 1622358360, ; 262: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1624863272, ; 263: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 298
	i32 1628113371, ; 264: Microsoft.IdentityModel.Protocols.OpenIdConnect => 0x610b09db => 196
	i32 1634654947, ; 265: CommunityToolkit.Maui.Core.dll => 0x616edae3 => 176
	i32 1635184631, ; 266: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 259
	i32 1636350590, ; 267: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 252
	i32 1638652436, ; 268: CommunityToolkit.Maui.MediaElement => 0x61abda14 => 177
	i32 1639515021, ; 269: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 270: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 271: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 272: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 273: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 292
	i32 1658251792, ; 274: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 301
	i32 1670060433, ; 275: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 247
	i32 1675553242, ; 276: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 277: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 278: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 279: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 280: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 281: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 282: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 310
	i32 1700397376, ; 283: ExoPlayer.Transformer => 0x655a0140 => 227
	i32 1701541528, ; 284: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 285: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 268
	i32 1726116996, ; 286: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 287: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 288: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 243
	i32 1736233607, ; 289: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 348
	i32 1743415430, ; 290: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 326
	i32 1744735666, ; 291: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 292: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 293: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 294: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 295: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765620304, ; 296: ExoPlayer.Core => 0x693d3a50 => 217
	i32 1765942094, ; 297: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 298: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 291
	i32 1770582343, ; 299: Microsoft.Extensions.Logging.dll => 0x6988f147 => 185
	i32 1776026572, ; 300: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 301: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 302: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782862114, ; 303: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 342
	i32 1788241197, ; 304: Xamarin.AndroidX.Fragment => 0x6a96652d => 261
	i32 1793755602, ; 305: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 334
	i32 1794500907, ; 306: Microsoft.Identity.Client.dll => 0x6af5e92b => 190
	i32 1796167890, ; 307: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 179
	i32 1808609942, ; 308: Xamarin.AndroidX.Loader => 0x6bcd3296 => 275
	i32 1813058853, ; 309: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 309
	i32 1813201214, ; 310: Xamarin.Google.Android.Material => 0x6c13413e => 301
	i32 1818569960, ; 311: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 281
	i32 1818787751, ; 312: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 313: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 314: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1828688058, ; 315: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 186
	i32 1842015223, ; 316: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 354
	i32 1847515442, ; 317: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 230
	i32 1853025655, ; 318: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 351
	i32 1858542181, ; 319: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1870277092, ; 320: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1871986876, ; 321: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll => 0x6f9440bc => 196
	i32 1875935024, ; 322: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 333
	i32 1879696579, ; 323: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 324: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 241
	i32 1888955245, ; 325: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 326: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 327: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900610850, ; 328: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 329: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1926145099, ; 330: ExoPlayer.Container.dll => 0x72cea44b => 216
	i32 1939592360, ; 331: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 332: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 333: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 288
	i32 1968388702, ; 334: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 181
	i32 1983156543, ; 335: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 310
	i32 1984283898, ; 336: ExoPlayer.Ext.MediaSession.dll => 0x7645c4fa => 224
	i32 1985761444, ; 337: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 232
	i32 1986222447, ; 338: Microsoft.IdentityModel.Tokens.dll => 0x7663596f => 197
	i32 2003115576, ; 339: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 330
	i32 2011961780, ; 340: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 341: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 272
	i32 2025202353, ; 342: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 325
	i32 2031763787, ; 343: Xamarin.Android.Glide => 0x791a414b => 229
	i32 2040764568, ; 344: Microsoft.Identity.Client.Extensions.Msal.dll => 0x79a39898 => 191
	i32 2045470958, ; 345: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 346: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 267
	i32 2060060697, ; 347: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 348: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 329
	i32 2070888862, ; 349: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 350: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090596640, ; 351: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2106312818, ; 352: ExoPlayer.Decoder => 0x7d8bc872 => 221
	i32 2113912252, ; 353: ExoPlayer.UI => 0x7dffbdbc => 228
	i32 2127167465, ; 354: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 355: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 356: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 357: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 358: Microsoft.Maui => 0x80bd55ad => 201
	i32 2169148018, ; 359: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 337
	i32 2181898931, ; 360: Microsoft.Extensions.Options.dll => 0x820d22b3 => 188
	i32 2192057212, ; 361: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 186
	i32 2193016926, ; 362: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 363: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 314
	i32 2201231467, ; 364: System.Net.Http => 0x8334206b => 64
	i32 2202964214, ; 365: ExoPlayer.dll => 0x834e90f6 => 214
	i32 2207618523, ; 366: it\Microsoft.Maui.Controls.resources => 0x839595db => 339
	i32 2217644978, ; 367: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 295
	i32 2222056684, ; 368: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2228745826, ; 369: pt-BR\Microsoft.Data.SqlClient.resources => 0x84d7f662 => 321
	i32 2239138732, ; 370: ExoPlayer.SmoothStreaming => 0x85768bac => 226
	i32 2244775296, ; 371: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 276
	i32 2252106437, ; 372: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2253551641, ; 373: Microsoft.IdentityModel.Protocols => 0x86527819 => 195
	i32 2256313426, ; 374: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 375: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 376: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 182
	i32 2267999099, ; 377: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 231
	i32 2270573516, ; 378: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 333
	i32 2279755925, ; 379: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 284
	i32 2293034957, ; 380: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 381: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 382: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 383: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 343
	i32 2305521784, ; 384: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2309278602, ; 385: ko\Microsoft.Data.SqlClient.resources => 0x89a4cb8a => 320
	i32 2315684594, ; 386: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 235
	i32 2320631194, ; 387: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2340441535, ; 388: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 389: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 390: System.Net.Primitives => 0x8c40e0db => 70
	i32 2368005991, ; 391: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2369706906, ; 392: Microsoft.IdentityModel.Logging => 0x8d3edb9a => 194
	i32 2371007202, ; 393: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 181
	i32 2378619854, ; 394: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 395: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 396: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 338
	i32 2401565422, ; 397: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 398: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 258
	i32 2421380589, ; 399: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 400: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 245
	i32 2427813419, ; 401: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 335
	i32 2435356389, ; 402: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 403: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2437192331, ; 404: CommunityToolkit.Maui.MediaElement.dll => 0x91449a8b => 177
	i32 2454642406, ; 405: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 406: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 407: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465532216, ; 408: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 248
	i32 2471841756, ; 409: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 410: Java.Interop.dll => 0x93918882 => 168
	i32 2476233210, ; 411: ExoPlayer => 0x939851fa => 214
	i32 2480646305, ; 412: Microsoft.Maui.Controls => 0x93dba8a1 => 199
	i32 2483903535, ; 413: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 414: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2490993605, ; 415: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 416: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 417: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 270
	i32 2509217888, ; 418: System.Diagnostics.EventLog => 0x958fa060 => 209
	i32 2515854816, ; 419: ExoPlayer.Common => 0x95f4e5e0 => 215
	i32 2522472828, ; 420: Xamarin.Android.Glide.dll => 0x9659e17c => 229
	i32 2538310050, ; 421: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 422: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 336
	i32 2562349572, ; 423: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 424: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2581783588, ; 425: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 271
	i32 2581819634, ; 426: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 294
	i32 2585220780, ; 427: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 428: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 429: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 430: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 345
	i32 2605712449, ; 431: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 314
	i32 2615233544, ; 432: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 262
	i32 2616218305, ; 433: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 187
	i32 2617129537, ; 434: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 435: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 436: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 252
	i32 2624644809, ; 437: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 257
	i32 2626028643, ; 438: ExoPlayer.Rtsp.dll => 0x9c860463 => 225
	i32 2626831493, ; 439: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 340
	i32 2627185994, ; 440: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2628210652, ; 441: System.Memory.Data => 0x9ca74fdc => 211
	i32 2629843544, ; 442: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 443: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 266
	i32 2640290731, ; 444: Microsoft.IdentityModel.Logging.dll => 0x9d5fa3ab => 194
	i32 2640706905, ; 445: Azure.Core => 0x9d65fd59 => 173
	i32 2660759594, ; 446: System.Security.Cryptography.ProtectedData.dll => 0x9e97f82a => 213
	i32 2663391936, ; 447: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 231
	i32 2663698177, ; 448: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 449: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 450: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 451: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2677098746, ; 452: Azure.Identity.dll => 0x9f9148fa => 174
	i32 2686887180, ; 453: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 454: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 455: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 292
	i32 2713040075, ; 456: ExoPlayer.Hls => 0xa1b5b4cb => 223
	i32 2715334215, ; 457: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 458: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 459: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 460: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 461: Xamarin.AndroidX.Activity => 0xa2e0939b => 233
	i32 2735172069, ; 462: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 463: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 239
	i32 2740051746, ; 464: Microsoft.Identity.Client => 0xa351df22 => 190
	i32 2740948882, ; 465: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2748088231, ; 466: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 467: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 346
	i32 2755098380, ; 468: Microsoft.SqlServer.Server.dll => 0xa437770c => 204
	i32 2758225723, ; 469: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 200
	i32 2764765095, ; 470: Microsoft.Maui.dll => 0xa4caf7a7 => 201
	i32 2765824710, ; 471: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 472: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 308
	i32 2778768386, ; 473: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 297
	i32 2779977773, ; 474: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 285
	i32 2785988530, ; 475: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 352
	i32 2788224221, ; 476: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 262
	i32 2796087574, ; 477: ExoPlayer.Extractor.dll => 0xa6a8e916 => 222
	i32 2801831435, ; 478: Microsoft.Maui.Graphics => 0xa7008e0b => 203
	i32 2803228030, ; 479: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2804509662, ; 480: es/Microsoft.Data.SqlClient.resources.dll => 0xa7296bde => 316
	i32 2806116107, ; 481: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 331
	i32 2810250172, ; 482: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 249
	i32 2819470561, ; 483: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 484: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 485: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 285
	i32 2824502124, ; 486: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 487: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 344
	i32 2838993487, ; 488: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 273
	i32 2841937114, ; 489: it/Microsoft.Data.SqlClient.resources.dll => 0xa96484da => 318
	i32 2849599387, ; 490: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 491: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 297
	i32 2855708567, ; 492: Xamarin.AndroidX.Transition => 0xaa36a797 => 293
	i32 2861098320, ; 493: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 494: Microsoft.Maui.Essentials => 0xaa8a4878 => 202
	i32 2867946736, ; 495: System.Security.Cryptography.ProtectedData => 0xaaf164f0 => 213
	i32 2868488919, ; 496: CommunityToolkit.Maui.Core => 0xaaf9aad7 => 176
	i32 2870099610, ; 497: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 234
	i32 2875164099, ; 498: Jsr305Binding.dll => 0xab5f85c3 => 302
	i32 2875220617, ; 499: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 500: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 260
	i32 2887636118, ; 501: System.Net.dll => 0xac1dd496 => 81
	i32 2899753641, ; 502: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 503: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 504: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 505: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 506: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2916838712, ; 507: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 298
	i32 2919462931, ; 508: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 509: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 236
	i32 2936416060, ; 510: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 511: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 512: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2944313911, ; 513: System.Configuration.ConfigurationManager.dll => 0xaf7eaa37 => 208
	i32 2959614098, ; 514: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2960379616, ; 515: Xamarin.Google.Guava => 0xb073cee0 => 305
	i32 2968338931, ; 516: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 517: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 518: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 256
	i32 2987532451, ; 519: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 288
	i32 2996846495, ; 520: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 269
	i32 3012788804, ; 521: System.Configuration.ConfigurationManager => 0xb3938244 => 208
	i32 3016983068, ; 522: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 290
	i32 3023353419, ; 523: WindowsBase.dll => 0xb434b64b => 165
	i32 3023511517, ; 524: ru\Microsoft.Data.SqlClient.resources => 0xb4371fdd => 322
	i32 3024354802, ; 525: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 264
	i32 3027462113, ; 526: ExoPlayer.Common.dll => 0xb47367e1 => 215
	i32 3033605958, ; 527: System.Memory.Data.dll => 0xb4d12746 => 211
	i32 3038032645, ; 528: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 359
	i32 3056245963, ; 529: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 287
	i32 3057625584, ; 530: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 278
	i32 3059408633, ; 531: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 532: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 533: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 534: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 337
	i32 3084678329, ; 535: Microsoft.IdentityModel.Tokens => 0xb7dc74b9 => 197
	i32 3090735792, ; 536: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 537: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 538: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3111772706, ; 539: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 540: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 541: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 542: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3144327419, ; 543: ExoPlayer.Hls.dll => 0xbb6aa0fb => 223
	i32 3147165239, ; 544: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3148237826, ; 545: GoogleGson.dll => 0xbba64c02 => 178
	i32 3158628304, ; 546: zh-Hant/Microsoft.Data.SqlClient.resources.dll => 0xbc44d7d0 => 324
	i32 3159123045, ; 547: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 548: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 549: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 279
	i32 3190271366, ; 550: ExoPlayer.Decoder.dll => 0xbe27ad86 => 221
	i32 3192346100, ; 551: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 552: System.Web => 0xbe592c0c => 153
	i32 3204380047, ; 553: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 554: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 555: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 255
	i32 3220365878, ; 556: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 557: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 558: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3258312781, ; 559: Xamarin.AndroidX.CardView => 0xc235e84d => 243
	i32 3265493905, ; 560: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 561: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3268887220, ; 562: fr/Microsoft.Data.SqlClient.resources.dll => 0xc2d742b4 => 317
	i32 3276600297, ; 563: pt-BR/Microsoft.Data.SqlClient.resources.dll => 0xc34cf3e9 => 321
	i32 3277815716, ; 564: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3279906254, ; 565: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 566: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 567: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 568: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 569: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 570: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 332
	i32 3312457198, ; 571: Microsoft.IdentityModel.JsonWebTokens => 0xc57015ee => 193
	i32 3316684772, ; 572: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 573: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 253
	i32 3317144872, ; 574: System.Data => 0xc5b79d28 => 24
	i32 3329734229, ; 575: ExoPlayer.Database => 0xc677b655 => 219
	i32 3340431453, ; 576: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 241
	i32 3343947874, ; 577: fr\Microsoft.Data.SqlClient.resources => 0xc7509862 => 317
	i32 3345895724, ; 578: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 283
	i32 3346324047, ; 579: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 280
	i32 3357674450, ; 580: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 349
	i32 3358260929, ; 581: System.Text.Json => 0xc82afec1 => 137
	i32 3362336904, ; 582: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 234
	i32 3362522851, ; 583: Xamarin.AndroidX.Core => 0xc86c06e3 => 250
	i32 3366347497, ; 584: Java.Interop => 0xc8a662e9 => 168
	i32 3374879918, ; 585: Microsoft.IdentityModel.Protocols.dll => 0xc92894ae => 195
	i32 3374999561, ; 586: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 284
	i32 3381016424, ; 587: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 328
	i32 3395150330, ; 588: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3396979385, ; 589: ExoPlayer.Transformer.dll => 0xca79cab9 => 227
	i32 3403906625, ; 590: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 591: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 254
	i32 3428513518, ; 592: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 183
	i32 3429136800, ; 593: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 594: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 595: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 257
	i32 3445260447, ; 596: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 597: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 198
	i32 3463511458, ; 598: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 336
	i32 3471940407, ; 599: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 600: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 601: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 349
	i32 3484440000, ; 602: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 348
	i32 3485117614, ; 603: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 604: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 605: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 246
	i32 3509114376, ; 606: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 607: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 608: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 609: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3545306353, ; 610: Microsoft.Data.SqlClient => 0xd35114f1 => 180
	i32 3555084973, ; 611: de\Microsoft.Data.SqlClient.resources => 0xd3e64aad => 315
	i32 3558648585, ; 612: System.ClientModel => 0xd41cab09 => 207
	i32 3560100363, ; 613: System.Threading.Timer => 0xd432d20b => 147
	i32 3561949811, ; 614: Azure.Core.dll => 0xd44f0a73 => 173
	i32 3562829038, ; 615: Sharing Place => 0xd45c74ee => 0
	i32 3570554715, ; 616: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3570608287, ; 617: System.Runtime.Caching.dll => 0xd4d3289f => 212
	i32 3580758918, ; 618: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 356
	i32 3597029428, ; 619: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 232
	i32 3598340787, ; 620: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 621: System.Linq.dll => 0xd715a361 => 61
	i32 3624195450, ; 622: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 623: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 282
	i32 3633644679, ; 624: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 236
	i32 3638274909, ; 625: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 626: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 267
	i32 3643446276, ; 627: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 353
	i32 3643854240, ; 628: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 279
	i32 3645089577, ; 629: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 630: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 182
	i32 3660523487, ; 631: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3660726404, ; 632: Plugin.Maui.Audio.dll => 0xda324084 => 206
	i32 3672681054, ; 633: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3682565725, ; 634: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 242
	i32 3684561358, ; 635: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 246
	i32 3697841164, ; 636: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 358
	i32 3700591436, ; 637: Microsoft.IdentityModel.Abstractions.dll => 0xdc928b4c => 192
	i32 3700866549, ; 638: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 639: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 251
	i32 3716563718, ; 640: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 641: Xamarin.AndroidX.Annotation => 0xdda814c6 => 235
	i32 3724971120, ; 642: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 278
	i32 3732100267, ; 643: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 644: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 645: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 646: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3786282454, ; 647: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 244
	i32 3792276235, ; 648: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 649: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 198
	i32 3802395368, ; 650: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3803019198, ; 651: zh-Hans/Microsoft.Data.SqlClient.resources.dll => 0xe2ad77be => 323
	i32 3817368567, ; 652: CommunityToolkit.Maui.dll => 0xe3886bf7 => 175
	i32 3819260425, ; 653: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3822602673, ; 654: Xamarin.AndroidX.Media => 0xe3d849b1 => 277
	i32 3823082795, ; 655: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 656: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 657: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 184
	i32 3844307129, ; 658: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3848348906, ; 659: es\Microsoft.Data.SqlClient.resources => 0xe56124ea => 316
	i32 3849253459, ; 660: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 661: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 662: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 663: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3885497537, ; 664: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 665: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 293
	i32 3888767677, ; 666: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 283
	i32 3889960447, ; 667: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 357
	i32 3896106733, ; 668: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 669: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 250
	i32 3901907137, ; 670: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 671: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 672: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 296
	i32 3928044579, ; 673: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3930554604, ; 674: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 675: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 281
	i32 3945713374, ; 676: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 677: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 678: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 238
	i32 3959773229, ; 679: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 269
	i32 3980434154, ; 680: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 352
	i32 3987592930, ; 681: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 334
	i32 4003436829, ; 682: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4015948917, ; 683: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 237
	i32 4025784931, ; 684: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 685: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 200
	i32 4054681211, ; 686: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4068434129, ; 687: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 688: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4094352644, ; 689: Microsoft.Maui.Essentials.dll => 0xf40add04 => 202
	i32 4099507663, ; 690: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 691: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 692: Xamarin.AndroidX.Emoji2 => 0xf479582c => 258
	i32 4102112229, ; 693: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 347
	i32 4125707920, ; 694: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 342
	i32 4126470640, ; 695: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 183
	i32 4127667938, ; 696: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 697: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 698: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 699: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 354
	i32 4151237749, ; 700: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 701: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 702: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 703: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4173364138, ; 704: ExoPlayer.SmoothStreaming.dll => 0xf8c07baa => 226
	i32 4181436372, ; 705: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 706: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 274
	i32 4185676441, ; 707: System.Security => 0xf97c5a99 => 130
	i32 4190597220, ; 708: ExoPlayer.Core.dll => 0xf9c77064 => 217
	i32 4196529839, ; 709: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 710: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 711: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 251
	i32 4257443520, ; 712: ko/Microsoft.Data.SqlClient.resources.dll => 0xfdc36ec0 => 320
	i32 4258378803, ; 713: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 273
	i32 4260525087, ; 714: System.Buffers => 0xfdf2741f => 7
	i32 4263231520, ; 715: System.IdentityModel.Tokens.Jwt.dll => 0xfe1bc020 => 210
	i32 4271975918, ; 716: Microsoft.Maui.Controls.dll => 0xfea12dee => 199
	i32 4274976490, ; 717: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 718: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 274
	i32 4294763496 ; 719: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 260
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [720 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 205, ; 2
	i32 108, ; 3
	i32 270, ; 4
	i32 307, ; 5
	i32 48, ; 6
	i32 80, ; 7
	i32 145, ; 8
	i32 318, ; 9
	i32 319, ; 10
	i32 30, ; 11
	i32 358, ; 12
	i32 124, ; 13
	i32 203, ; 14
	i32 102, ; 15
	i32 289, ; 16
	i32 107, ; 17
	i32 289, ; 18
	i32 139, ; 19
	i32 311, ; 20
	i32 319, ; 21
	i32 77, ; 22
	i32 124, ; 23
	i32 13, ; 24
	i32 244, ; 25
	i32 322, ; 26
	i32 132, ; 27
	i32 0, ; 28
	i32 291, ; 29
	i32 151, ; 30
	i32 355, ; 31
	i32 356, ; 32
	i32 18, ; 33
	i32 242, ; 34
	i32 26, ; 35
	i32 264, ; 36
	i32 1, ; 37
	i32 59, ; 38
	i32 42, ; 39
	i32 91, ; 40
	i32 247, ; 41
	i32 323, ; 42
	i32 306, ; 43
	i32 147, ; 44
	i32 266, ; 45
	i32 263, ; 46
	i32 327, ; 47
	i32 54, ; 48
	i32 218, ; 49
	i32 69, ; 50
	i32 355, ; 51
	i32 233, ; 52
	i32 83, ; 53
	i32 204, ; 54
	i32 340, ; 55
	i32 265, ; 56
	i32 339, ; 57
	i32 131, ; 58
	i32 205, ; 59
	i32 55, ; 60
	i32 149, ; 61
	i32 74, ; 62
	i32 145, ; 63
	i32 62, ; 64
	i32 146, ; 65
	i32 359, ; 66
	i32 165, ; 67
	i32 351, ; 68
	i32 248, ; 69
	i32 12, ; 70
	i32 261, ; 71
	i32 125, ; 72
	i32 219, ; 73
	i32 152, ; 74
	i32 113, ; 75
	i32 166, ; 76
	i32 164, ; 77
	i32 263, ; 78
	i32 192, ; 79
	i32 276, ; 80
	i32 84, ; 81
	i32 338, ; 82
	i32 332, ; 83
	i32 189, ; 84
	i32 150, ; 85
	i32 311, ; 86
	i32 60, ; 87
	i32 185, ; 88
	i32 51, ; 89
	i32 103, ; 90
	i32 114, ; 91
	i32 179, ; 92
	i32 40, ; 93
	i32 302, ; 94
	i32 300, ; 95
	i32 120, ; 96
	i32 346, ; 97
	i32 175, ; 98
	i32 52, ; 99
	i32 44, ; 100
	i32 119, ; 101
	i32 216, ; 102
	i32 253, ; 103
	i32 344, ; 104
	i32 259, ; 105
	i32 81, ; 106
	i32 136, ; 107
	i32 296, ; 108
	i32 240, ; 109
	i32 8, ; 110
	i32 73, ; 111
	i32 326, ; 112
	i32 155, ; 113
	i32 313, ; 114
	i32 154, ; 115
	i32 92, ; 116
	i32 308, ; 117
	i32 45, ; 118
	i32 341, ; 119
	i32 329, ; 120
	i32 312, ; 121
	i32 109, ; 122
	i32 207, ; 123
	i32 129, ; 124
	i32 25, ; 125
	i32 230, ; 126
	i32 72, ; 127
	i32 55, ; 128
	i32 46, ; 129
	i32 350, ; 130
	i32 188, ; 131
	i32 254, ; 132
	i32 22, ; 133
	i32 268, ; 134
	i32 218, ; 135
	i32 86, ; 136
	i32 43, ; 137
	i32 160, ; 138
	i32 71, ; 139
	i32 282, ; 140
	i32 3, ; 141
	i32 42, ; 142
	i32 63, ; 143
	i32 16, ; 144
	i32 53, ; 145
	i32 224, ; 146
	i32 353, ; 147
	i32 307, ; 148
	i32 222, ; 149
	i32 105, ; 150
	i32 312, ; 151
	i32 303, ; 152
	i32 265, ; 153
	i32 34, ; 154
	i32 158, ; 155
	i32 85, ; 156
	i32 32, ; 157
	i32 12, ; 158
	i32 51, ; 159
	i32 56, ; 160
	i32 286, ; 161
	i32 36, ; 162
	i32 228, ; 163
	i32 184, ; 164
	i32 328, ; 165
	i32 304, ; 166
	i32 238, ; 167
	i32 35, ; 168
	i32 58, ; 169
	i32 315, ; 170
	i32 272, ; 171
	i32 191, ; 172
	i32 178, ; 173
	i32 17, ; 174
	i32 309, ; 175
	i32 209, ; 176
	i32 164, ; 177
	i32 341, ; 178
	i32 271, ; 179
	i32 187, ; 180
	i32 180, ; 181
	i32 299, ; 182
	i32 225, ; 183
	i32 347, ; 184
	i32 153, ; 185
	i32 295, ; 186
	i32 280, ; 187
	i32 345, ; 188
	i32 240, ; 189
	i32 29, ; 190
	i32 52, ; 191
	i32 343, ; 192
	i32 300, ; 193
	i32 5, ; 194
	i32 327, ; 195
	i32 305, ; 196
	i32 290, ; 197
	i32 294, ; 198
	i32 245, ; 199
	i32 313, ; 200
	i32 237, ; 201
	i32 256, ; 202
	i32 85, ; 203
	i32 220, ; 204
	i32 299, ; 205
	i32 61, ; 206
	i32 112, ; 207
	i32 206, ; 208
	i32 57, ; 209
	i32 357, ; 210
	i32 286, ; 211
	i32 99, ; 212
	i32 277, ; 213
	i32 19, ; 214
	i32 249, ; 215
	i32 306, ; 216
	i32 111, ; 217
	i32 101, ; 218
	i32 102, ; 219
	i32 325, ; 220
	i32 104, ; 221
	i32 303, ; 222
	i32 71, ; 223
	i32 38, ; 224
	i32 32, ; 225
	i32 103, ; 226
	i32 73, ; 227
	i32 210, ; 228
	i32 331, ; 229
	i32 9, ; 230
	i32 123, ; 231
	i32 46, ; 232
	i32 239, ; 233
	i32 189, ; 234
	i32 9, ; 235
	i32 220, ; 236
	i32 43, ; 237
	i32 4, ; 238
	i32 287, ; 239
	i32 335, ; 240
	i32 193, ; 241
	i32 330, ; 242
	i32 31, ; 243
	i32 138, ; 244
	i32 92, ; 245
	i32 93, ; 246
	i32 350, ; 247
	i32 212, ; 248
	i32 49, ; 249
	i32 141, ; 250
	i32 112, ; 251
	i32 140, ; 252
	i32 174, ; 253
	i32 255, ; 254
	i32 115, ; 255
	i32 324, ; 256
	i32 304, ; 257
	i32 157, ; 258
	i32 76, ; 259
	i32 79, ; 260
	i32 275, ; 261
	i32 37, ; 262
	i32 298, ; 263
	i32 196, ; 264
	i32 176, ; 265
	i32 259, ; 266
	i32 252, ; 267
	i32 177, ; 268
	i32 64, ; 269
	i32 138, ; 270
	i32 15, ; 271
	i32 116, ; 272
	i32 292, ; 273
	i32 301, ; 274
	i32 247, ; 275
	i32 48, ; 276
	i32 70, ; 277
	i32 80, ; 278
	i32 126, ; 279
	i32 94, ; 280
	i32 121, ; 281
	i32 310, ; 282
	i32 227, ; 283
	i32 26, ; 284
	i32 268, ; 285
	i32 97, ; 286
	i32 28, ; 287
	i32 243, ; 288
	i32 348, ; 289
	i32 326, ; 290
	i32 149, ; 291
	i32 169, ; 292
	i32 4, ; 293
	i32 98, ; 294
	i32 33, ; 295
	i32 217, ; 296
	i32 93, ; 297
	i32 291, ; 298
	i32 185, ; 299
	i32 21, ; 300
	i32 41, ; 301
	i32 170, ; 302
	i32 342, ; 303
	i32 261, ; 304
	i32 334, ; 305
	i32 190, ; 306
	i32 179, ; 307
	i32 275, ; 308
	i32 309, ; 309
	i32 301, ; 310
	i32 281, ; 311
	i32 2, ; 312
	i32 134, ; 313
	i32 111, ; 314
	i32 186, ; 315
	i32 354, ; 316
	i32 230, ; 317
	i32 351, ; 318
	i32 58, ; 319
	i32 95, ; 320
	i32 196, ; 321
	i32 333, ; 322
	i32 39, ; 323
	i32 241, ; 324
	i32 25, ; 325
	i32 94, ; 326
	i32 89, ; 327
	i32 99, ; 328
	i32 10, ; 329
	i32 216, ; 330
	i32 87, ; 331
	i32 100, ; 332
	i32 288, ; 333
	i32 181, ; 334
	i32 310, ; 335
	i32 224, ; 336
	i32 232, ; 337
	i32 197, ; 338
	i32 330, ; 339
	i32 7, ; 340
	i32 272, ; 341
	i32 325, ; 342
	i32 229, ; 343
	i32 191, ; 344
	i32 88, ; 345
	i32 267, ; 346
	i32 154, ; 347
	i32 329, ; 348
	i32 33, ; 349
	i32 116, ; 350
	i32 82, ; 351
	i32 221, ; 352
	i32 228, ; 353
	i32 20, ; 354
	i32 11, ; 355
	i32 162, ; 356
	i32 3, ; 357
	i32 201, ; 358
	i32 337, ; 359
	i32 188, ; 360
	i32 186, ; 361
	i32 84, ; 362
	i32 314, ; 363
	i32 64, ; 364
	i32 214, ; 365
	i32 339, ; 366
	i32 295, ; 367
	i32 143, ; 368
	i32 321, ; 369
	i32 226, ; 370
	i32 276, ; 371
	i32 157, ; 372
	i32 195, ; 373
	i32 41, ; 374
	i32 117, ; 375
	i32 182, ; 376
	i32 231, ; 377
	i32 333, ; 378
	i32 284, ; 379
	i32 131, ; 380
	i32 75, ; 381
	i32 66, ; 382
	i32 343, ; 383
	i32 172, ; 384
	i32 320, ; 385
	i32 235, ; 386
	i32 143, ; 387
	i32 106, ; 388
	i32 151, ; 389
	i32 70, ; 390
	i32 156, ; 391
	i32 194, ; 392
	i32 181, ; 393
	i32 121, ; 394
	i32 127, ; 395
	i32 338, ; 396
	i32 152, ; 397
	i32 258, ; 398
	i32 141, ; 399
	i32 245, ; 400
	i32 335, ; 401
	i32 20, ; 402
	i32 14, ; 403
	i32 177, ; 404
	i32 135, ; 405
	i32 75, ; 406
	i32 59, ; 407
	i32 248, ; 408
	i32 167, ; 409
	i32 168, ; 410
	i32 214, ; 411
	i32 199, ; 412
	i32 15, ; 413
	i32 74, ; 414
	i32 6, ; 415
	i32 23, ; 416
	i32 270, ; 417
	i32 209, ; 418
	i32 215, ; 419
	i32 229, ; 420
	i32 91, ; 421
	i32 336, ; 422
	i32 1, ; 423
	i32 136, ; 424
	i32 271, ; 425
	i32 294, ; 426
	i32 134, ; 427
	i32 69, ; 428
	i32 146, ; 429
	i32 345, ; 430
	i32 314, ; 431
	i32 262, ; 432
	i32 187, ; 433
	i32 88, ; 434
	i32 96, ; 435
	i32 252, ; 436
	i32 257, ; 437
	i32 225, ; 438
	i32 340, ; 439
	i32 31, ; 440
	i32 211, ; 441
	i32 45, ; 442
	i32 266, ; 443
	i32 194, ; 444
	i32 173, ; 445
	i32 213, ; 446
	i32 231, ; 447
	i32 109, ; 448
	i32 158, ; 449
	i32 35, ; 450
	i32 22, ; 451
	i32 174, ; 452
	i32 114, ; 453
	i32 57, ; 454
	i32 292, ; 455
	i32 223, ; 456
	i32 144, ; 457
	i32 118, ; 458
	i32 120, ; 459
	i32 110, ; 460
	i32 233, ; 461
	i32 139, ; 462
	i32 239, ; 463
	i32 190, ; 464
	i32 54, ; 465
	i32 105, ; 466
	i32 346, ; 467
	i32 204, ; 468
	i32 200, ; 469
	i32 201, ; 470
	i32 133, ; 471
	i32 308, ; 472
	i32 297, ; 473
	i32 285, ; 474
	i32 352, ; 475
	i32 262, ; 476
	i32 222, ; 477
	i32 203, ; 478
	i32 159, ; 479
	i32 316, ; 480
	i32 331, ; 481
	i32 249, ; 482
	i32 163, ; 483
	i32 132, ; 484
	i32 285, ; 485
	i32 161, ; 486
	i32 344, ; 487
	i32 273, ; 488
	i32 318, ; 489
	i32 140, ; 490
	i32 297, ; 491
	i32 293, ; 492
	i32 169, ; 493
	i32 202, ; 494
	i32 213, ; 495
	i32 176, ; 496
	i32 234, ; 497
	i32 302, ; 498
	i32 40, ; 499
	i32 260, ; 500
	i32 81, ; 501
	i32 56, ; 502
	i32 37, ; 503
	i32 97, ; 504
	i32 166, ; 505
	i32 172, ; 506
	i32 298, ; 507
	i32 82, ; 508
	i32 236, ; 509
	i32 98, ; 510
	i32 30, ; 511
	i32 159, ; 512
	i32 208, ; 513
	i32 18, ; 514
	i32 305, ; 515
	i32 127, ; 516
	i32 119, ; 517
	i32 256, ; 518
	i32 288, ; 519
	i32 269, ; 520
	i32 208, ; 521
	i32 290, ; 522
	i32 165, ; 523
	i32 322, ; 524
	i32 264, ; 525
	i32 215, ; 526
	i32 211, ; 527
	i32 359, ; 528
	i32 287, ; 529
	i32 278, ; 530
	i32 170, ; 531
	i32 16, ; 532
	i32 144, ; 533
	i32 337, ; 534
	i32 197, ; 535
	i32 125, ; 536
	i32 118, ; 537
	i32 38, ; 538
	i32 115, ; 539
	i32 47, ; 540
	i32 142, ; 541
	i32 117, ; 542
	i32 223, ; 543
	i32 34, ; 544
	i32 178, ; 545
	i32 324, ; 546
	i32 95, ; 547
	i32 53, ; 548
	i32 279, ; 549
	i32 221, ; 550
	i32 129, ; 551
	i32 153, ; 552
	i32 24, ; 553
	i32 161, ; 554
	i32 255, ; 555
	i32 148, ; 556
	i32 104, ; 557
	i32 89, ; 558
	i32 243, ; 559
	i32 60, ; 560
	i32 142, ; 561
	i32 317, ; 562
	i32 321, ; 563
	i32 100, ; 564
	i32 5, ; 565
	i32 13, ; 566
	i32 122, ; 567
	i32 135, ; 568
	i32 28, ; 569
	i32 332, ; 570
	i32 193, ; 571
	i32 72, ; 572
	i32 253, ; 573
	i32 24, ; 574
	i32 219, ; 575
	i32 241, ; 576
	i32 317, ; 577
	i32 283, ; 578
	i32 280, ; 579
	i32 349, ; 580
	i32 137, ; 581
	i32 234, ; 582
	i32 250, ; 583
	i32 168, ; 584
	i32 195, ; 585
	i32 284, ; 586
	i32 328, ; 587
	i32 101, ; 588
	i32 227, ; 589
	i32 123, ; 590
	i32 254, ; 591
	i32 183, ; 592
	i32 163, ; 593
	i32 167, ; 594
	i32 257, ; 595
	i32 39, ; 596
	i32 198, ; 597
	i32 336, ; 598
	i32 17, ; 599
	i32 171, ; 600
	i32 349, ; 601
	i32 348, ; 602
	i32 137, ; 603
	i32 150, ; 604
	i32 246, ; 605
	i32 155, ; 606
	i32 130, ; 607
	i32 19, ; 608
	i32 65, ; 609
	i32 180, ; 610
	i32 315, ; 611
	i32 207, ; 612
	i32 147, ; 613
	i32 173, ; 614
	i32 0, ; 615
	i32 47, ; 616
	i32 212, ; 617
	i32 356, ; 618
	i32 232, ; 619
	i32 79, ; 620
	i32 61, ; 621
	i32 106, ; 622
	i32 282, ; 623
	i32 236, ; 624
	i32 49, ; 625
	i32 267, ; 626
	i32 353, ; 627
	i32 279, ; 628
	i32 14, ; 629
	i32 182, ; 630
	i32 68, ; 631
	i32 206, ; 632
	i32 171, ; 633
	i32 242, ; 634
	i32 246, ; 635
	i32 358, ; 636
	i32 192, ; 637
	i32 78, ; 638
	i32 251, ; 639
	i32 108, ; 640
	i32 235, ; 641
	i32 278, ; 642
	i32 67, ; 643
	i32 63, ; 644
	i32 27, ; 645
	i32 160, ; 646
	i32 244, ; 647
	i32 10, ; 648
	i32 198, ; 649
	i32 11, ; 650
	i32 323, ; 651
	i32 175, ; 652
	i32 78, ; 653
	i32 277, ; 654
	i32 126, ; 655
	i32 83, ; 656
	i32 184, ; 657
	i32 66, ; 658
	i32 316, ; 659
	i32 107, ; 660
	i32 65, ; 661
	i32 128, ; 662
	i32 122, ; 663
	i32 77, ; 664
	i32 293, ; 665
	i32 283, ; 666
	i32 357, ; 667
	i32 8, ; 668
	i32 250, ; 669
	i32 2, ; 670
	i32 44, ; 671
	i32 296, ; 672
	i32 156, ; 673
	i32 128, ; 674
	i32 281, ; 675
	i32 23, ; 676
	i32 133, ; 677
	i32 238, ; 678
	i32 269, ; 679
	i32 352, ; 680
	i32 334, ; 681
	i32 29, ; 682
	i32 237, ; 683
	i32 62, ; 684
	i32 200, ; 685
	i32 90, ; 686
	i32 87, ; 687
	i32 148, ; 688
	i32 202, ; 689
	i32 36, ; 690
	i32 86, ; 691
	i32 258, ; 692
	i32 347, ; 693
	i32 342, ; 694
	i32 183, ; 695
	i32 50, ; 696
	i32 6, ; 697
	i32 90, ; 698
	i32 354, ; 699
	i32 21, ; 700
	i32 162, ; 701
	i32 96, ; 702
	i32 50, ; 703
	i32 226, ; 704
	i32 113, ; 705
	i32 274, ; 706
	i32 130, ; 707
	i32 217, ; 708
	i32 76, ; 709
	i32 27, ; 710
	i32 251, ; 711
	i32 320, ; 712
	i32 273, ; 713
	i32 7, ; 714
	i32 210, ; 715
	i32 199, ; 716
	i32 110, ; 717
	i32 274, ; 718
	i32 260 ; 719
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.2xx @ 0d97e20b84d8e87c3502469ee395805907905fe3"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
