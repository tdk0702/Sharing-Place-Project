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

@assembly_image_cache = dso_local local_unnamed_addr global [339 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [672 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 249
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 283
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39485524, ; 6: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 7: System.Threading.Thread => 0x28aa24d => 145
	i32 57725457, ; 8: it\Microsoft.Data.SqlClient.resources => 0x370d211 => 294
	i32 57727992, ; 9: ja\Microsoft.Data.SqlClient.resources => 0x370dbf8 => 295
	i32 66541672, ; 10: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 11: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 334
	i32 68219467, ; 12: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 13: Microsoft.Maui.Graphics.dll => 0x44bb714 => 200
	i32 82292897, ; 14: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 15: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 267
	i32 117431740, ; 16: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 17: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 267
	i32 122350210, ; 18: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 19: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 287
	i32 139659294, ; 20: ja/Microsoft.Data.SqlClient.resources.dll => 0x853081e => 295
	i32 142721839, ; 21: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149972175, ; 22: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 23: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 24: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 223
	i32 166535111, ; 25: ru/Microsoft.Data.SqlClient.resources.dll => 0x9ed1fc7 => 298
	i32 176265551, ; 26: System.ServiceProcess => 0xa81994f => 132
	i32 177853112, ; 27: Sharing Place.dll => 0xa99d2b8 => 0
	i32 182336117, ; 28: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 269
	i32 184328833, ; 29: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 30: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 331
	i32 199333315, ; 31: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 332
	i32 205061960, ; 32: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 33: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 221
	i32 220171995, ; 34: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 35: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 243
	i32 230752869, ; 36: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 37: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 38: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 39: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 40: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 226
	i32 264223668, ; 41: zh-Hans\Microsoft.Data.SqlClient.resources => 0xfbfbbb4 => 299
	i32 276479776, ; 42: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 43: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 245
	i32 280482487, ; 44: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 242
	i32 280992041, ; 45: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 303
	i32 291076382, ; 46: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 298918909, ; 47: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 48: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 331
	i32 318968648, ; 49: Xamarin.AndroidX.Activity.dll => 0x13031348 => 212
	i32 321597661, ; 50: System.Numerics => 0x132b30dd => 83
	i32 330147069, ; 51: Microsoft.SqlServer.Server => 0x13ada4fd => 201
	i32 336156722, ; 52: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 316
	i32 342366114, ; 53: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 244
	i32 356389973, ; 54: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 315
	i32 360082299, ; 55: System.ServiceModel.Web => 0x15766b7b => 131
	i32 367780167, ; 56: System.IO.Pipes => 0x15ebe147 => 55
	i32 374914964, ; 57: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 58: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 59: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 60: System.Memory.dll => 0x16fe439a => 62
	i32 392610295, ; 61: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 395744057, ; 62: _Microsoft.Android.Resource.Designer => 0x17969339 => 335
	i32 403441872, ; 63: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 64: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 327
	i32 441335492, ; 65: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 227
	i32 442565967, ; 66: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 67: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 240
	i32 451504562, ; 68: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 456227837, ; 69: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 70: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465846621, ; 71: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 72: System.dll => 0x1bff388e => 164
	i32 476646585, ; 73: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 242
	i32 485463106, ; 74: Microsoft.IdentityModel.Abstractions => 0x1cef9442 => 189
	i32 486930444, ; 75: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 255
	i32 498788369, ; 76: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 77: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 314
	i32 503918385, ; 78: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 308
	i32 513247710, ; 79: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 186
	i32 526420162, ; 80: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 81: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 287
	i32 530272170, ; 82: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 83: Microsoft.Extensions.Logging => 0x20216150 => 182
	i32 540030774, ; 84: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 85: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 86: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 548916678, ; 87: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 176
	i32 549171840, ; 88: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 89: Jsr305Binding => 0x213954e7 => 280
	i32 569601784, ; 90: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 278
	i32 577335427, ; 91: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 92: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 322
	i32 601371474, ; 93: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 94: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 613668793, ; 95: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 627609679, ; 96: Xamarin.AndroidX.CustomView => 0x2568904f => 232
	i32 627931235, ; 97: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 320
	i32 639843206, ; 98: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 238
	i32 643868501, ; 99: System.Net => 0x2660a755 => 81
	i32 662205335, ; 100: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 101: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 274
	i32 666292255, ; 102: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 219
	i32 672442732, ; 103: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 104: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 105: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 302
	i32 690569205, ; 106: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 107: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 289
	i32 693804605, ; 108: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 109: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 110: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 284
	i32 700358131, ; 111: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 112: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 317
	i32 709557578, ; 113: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 305
	i32 720511267, ; 114: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 288
	i32 722857257, ; 115: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 735137430, ; 116: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 752232764, ; 117: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 118: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 209
	i32 759454413, ; 119: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 120: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 121: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 122: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 326
	i32 789151979, ; 123: Microsoft.Extensions.Options => 0x2f0980eb => 185
	i32 790371945, ; 124: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 233
	i32 804715423, ; 125: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 126: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 247
	i32 823281589, ; 127: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 128: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 129: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 130: System.Net.Quic => 0x31b69d60 => 71
	i32 843511501, ; 131: Xamarin.AndroidX.Print => 0x3246f6cd => 260
	i32 873119928, ; 132: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 133: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 134: System.Net.Http.Json => 0x3463c971 => 63
	i32 904024072, ; 135: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 136: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 926902833, ; 137: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 329
	i32 928116545, ; 138: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 283
	i32 952186615, ; 139: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 956575887, ; 140: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 288
	i32 966729478, ; 141: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 281
	i32 967690846, ; 142: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 244
	i32 975236339, ; 143: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 144: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 145: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 146: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 147: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 148: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 149: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 150: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 264
	i32 1019214401, ; 151: System.Drawing => 0x3cbffa41 => 36
	i32 1028951442, ; 152: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 181
	i32 1029334545, ; 153: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 304
	i32 1031528504, ; 154: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 282
	i32 1035644815, ; 155: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 217
	i32 1036536393, ; 156: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 157: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1048439329, ; 158: de/Microsoft.Data.SqlClient.resources.dll => 0x3e7dea21 => 291
	i32 1052210849, ; 159: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 251
	i32 1062017875, ; 160: Microsoft.Identity.Client.Extensions.Msal => 0x3f4d1b53 => 188
	i32 1067306892, ; 161: GoogleGson => 0x3f9dcf8c => 175
	i32 1082857460, ; 162: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 163: Xamarin.Kotlin.StdLib => 0x409e66d8 => 285
	i32 1089913930, ; 164: System.Diagnostics.EventLog.dll => 0x40f6c44a => 203
	i32 1098259244, ; 165: System => 0x41761b2c => 164
	i32 1118262833, ; 166: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 317
	i32 1121599056, ; 167: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 250
	i32 1127624469, ; 168: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 184
	i32 1138436374, ; 169: Microsoft.Data.SqlClient.dll => 0x43db2916 => 177
	i32 1149092582, ; 170: Xamarin.AndroidX.Window => 0x447dc2e6 => 277
	i32 1168523401, ; 171: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 323
	i32 1170634674, ; 172: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 173: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 273
	i32 1178241025, ; 174: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 258
	i32 1203215381, ; 175: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 321
	i32 1204270330, ; 176: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 219
	i32 1208641965, ; 177: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1219128291, ; 178: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 179: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 319
	i32 1243150071, ; 180: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 278
	i32 1253011324, ; 181: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 182: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 303
	i32 1264511973, ; 183: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 268
	i32 1267360935, ; 184: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 272
	i32 1273260888, ; 185: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 224
	i32 1275534314, ; 186: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 289
	i32 1278448581, ; 187: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 216
	i32 1293217323, ; 188: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 235
	i32 1309188875, ; 189: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1322716291, ; 190: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 277
	i32 1324164729, ; 191: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 192: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1364015309, ; 193: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 194: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 333
	i32 1376866003, ; 195: Xamarin.AndroidX.SavedState => 0x52114ed3 => 264
	i32 1379779777, ; 196: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1402170036, ; 197: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 198: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 228
	i32 1408764838, ; 199: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 200: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 201: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1430672901, ; 202: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 301
	i32 1434145427, ; 203: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 204: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 281
	i32 1439761251, ; 205: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1452070440, ; 206: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 207: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 208: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 209: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1460893475, ; 210: System.IdentityModel.Tokens.Jwt => 0x57137723 => 204
	i32 1461004990, ; 211: es\Microsoft.Maui.Controls.resources => 0x57152abe => 307
	i32 1461234159, ; 212: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 213: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 214: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 215: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 218
	i32 1470490898, ; 216: Microsoft.Extensions.Primitives => 0x57a5e912 => 186
	i32 1479771757, ; 217: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 218: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 219: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 220: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 265
	i32 1493001747, ; 221: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 311
	i32 1498168481, ; 222: Microsoft.IdentityModel.JsonWebTokens.dll => 0x594c3ca1 => 190
	i32 1514721132, ; 223: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 306
	i32 1536373174, ; 224: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 225: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 226: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 227: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 228: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 326
	i32 1565310744, ; 229: System.Runtime.Caching => 0x5d4cbf18 => 206
	i32 1565862583, ; 230: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 231: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 232: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 233: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582305585, ; 234: Azure.Identity => 0x5e501131 => 174
	i32 1582372066, ; 235: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 234
	i32 1592978981, ; 236: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1596263029, ; 237: zh-Hant\Microsoft.Data.SqlClient.resources => 0x5f250a75 => 300
	i32 1597949149, ; 238: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 282
	i32 1601112923, ; 239: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1604827217, ; 240: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 241: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 242: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 254
	i32 1622358360, ; 243: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1624863272, ; 244: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 276
	i32 1628113371, ; 245: Microsoft.IdentityModel.Protocols.OpenIdConnect => 0x610b09db => 193
	i32 1635184631, ; 246: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 238
	i32 1636350590, ; 247: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 231
	i32 1639515021, ; 248: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 249: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 250: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 251: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 252: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 270
	i32 1658251792, ; 253: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 279
	i32 1670060433, ; 254: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 226
	i32 1675553242, ; 255: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 256: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 257: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 258: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 259: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 260: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 261: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 286
	i32 1701541528, ; 262: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 263: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 247
	i32 1726116996, ; 264: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 265: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 266: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 222
	i32 1736233607, ; 267: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 324
	i32 1743415430, ; 268: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 302
	i32 1744735666, ; 269: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 270: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 271: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 272: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 273: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765942094, ; 274: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 275: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 269
	i32 1770582343, ; 276: Microsoft.Extensions.Logging.dll => 0x6988f147 => 182
	i32 1776026572, ; 277: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 278: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 279: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782862114, ; 280: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 318
	i32 1788241197, ; 281: Xamarin.AndroidX.Fragment => 0x6a96652d => 240
	i32 1793755602, ; 282: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 310
	i32 1794500907, ; 283: Microsoft.Identity.Client.dll => 0x6af5e92b => 187
	i32 1796167890, ; 284: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 176
	i32 1808609942, ; 285: Xamarin.AndroidX.Loader => 0x6bcd3296 => 254
	i32 1813058853, ; 286: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 285
	i32 1813201214, ; 287: Xamarin.Google.Android.Material => 0x6c13413e => 279
	i32 1818569960, ; 288: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 259
	i32 1818787751, ; 289: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 290: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 291: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1828688058, ; 292: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 183
	i32 1842015223, ; 293: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 330
	i32 1847515442, ; 294: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 209
	i32 1853025655, ; 295: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 327
	i32 1858542181, ; 296: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1870277092, ; 297: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1871986876, ; 298: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll => 0x6f9440bc => 193
	i32 1875935024, ; 299: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 309
	i32 1879696579, ; 300: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 301: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 220
	i32 1888955245, ; 302: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 303: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 304: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900610850, ; 305: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 306: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1939592360, ; 307: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 308: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 309: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 266
	i32 1968388702, ; 310: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 178
	i32 1983156543, ; 311: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 286
	i32 1985761444, ; 312: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 211
	i32 1986222447, ; 313: Microsoft.IdentityModel.Tokens.dll => 0x7663596f => 194
	i32 2003115576, ; 314: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 306
	i32 2011961780, ; 315: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 316: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 251
	i32 2025202353, ; 317: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 301
	i32 2031763787, ; 318: Xamarin.Android.Glide => 0x791a414b => 208
	i32 2040764568, ; 319: Microsoft.Identity.Client.Extensions.Msal.dll => 0x79a39898 => 188
	i32 2045470958, ; 320: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 321: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 246
	i32 2060060697, ; 322: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 323: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 305
	i32 2070888862, ; 324: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 325: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090596640, ; 326: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2127167465, ; 327: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 328: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 329: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 330: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 331: Microsoft.Maui => 0x80bd55ad => 198
	i32 2169148018, ; 332: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 313
	i32 2181898931, ; 333: Microsoft.Extensions.Options.dll => 0x820d22b3 => 185
	i32 2192057212, ; 334: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 183
	i32 2193016926, ; 335: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 336: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 290
	i32 2201231467, ; 337: System.Net.Http => 0x8334206b => 64
	i32 2207618523, ; 338: it\Microsoft.Maui.Controls.resources => 0x839595db => 315
	i32 2217644978, ; 339: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 273
	i32 2222056684, ; 340: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2228745826, ; 341: pt-BR\Microsoft.Data.SqlClient.resources => 0x84d7f662 => 297
	i32 2244775296, ; 342: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 255
	i32 2252106437, ; 343: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2253551641, ; 344: Microsoft.IdentityModel.Protocols => 0x86527819 => 192
	i32 2256313426, ; 345: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 346: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 347: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 179
	i32 2267999099, ; 348: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 210
	i32 2270573516, ; 349: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 309
	i32 2279755925, ; 350: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 262
	i32 2293034957, ; 351: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 352: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 353: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 354: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 319
	i32 2305521784, ; 355: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2309278602, ; 356: ko\Microsoft.Data.SqlClient.resources => 0x89a4cb8a => 296
	i32 2315684594, ; 357: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 214
	i32 2320631194, ; 358: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2340441535, ; 359: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 360: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 361: System.Net.Primitives => 0x8c40e0db => 70
	i32 2368005991, ; 362: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2369706906, ; 363: Microsoft.IdentityModel.Logging => 0x8d3edb9a => 191
	i32 2371007202, ; 364: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 178
	i32 2378619854, ; 365: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 366: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 367: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 314
	i32 2401565422, ; 368: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 369: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 237
	i32 2421380589, ; 370: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 371: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 224
	i32 2427813419, ; 372: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 311
	i32 2435356389, ; 373: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 374: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2454642406, ; 375: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 376: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 377: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465532216, ; 378: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 227
	i32 2471841756, ; 379: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 380: Java.Interop.dll => 0x93918882 => 168
	i32 2480646305, ; 381: Microsoft.Maui.Controls => 0x93dba8a1 => 196
	i32 2483903535, ; 382: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 383: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2490993605, ; 384: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 385: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 386: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 249
	i32 2509217888, ; 387: System.Diagnostics.EventLog => 0x958fa060 => 203
	i32 2522472828, ; 388: Xamarin.Android.Glide.dll => 0x9659e17c => 208
	i32 2538310050, ; 389: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 390: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 312
	i32 2562349572, ; 391: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 392: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2581783588, ; 393: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 250
	i32 2581819634, ; 394: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 272
	i32 2585220780, ; 395: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 396: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 397: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 398: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 321
	i32 2605712449, ; 399: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 290
	i32 2615233544, ; 400: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 241
	i32 2616218305, ; 401: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 184
	i32 2617129537, ; 402: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 403: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 404: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 231
	i32 2624644809, ; 405: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 236
	i32 2626831493, ; 406: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 316
	i32 2627185994, ; 407: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2628210652, ; 408: System.Memory.Data => 0x9ca74fdc => 205
	i32 2629843544, ; 409: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 410: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 245
	i32 2640290731, ; 411: Microsoft.IdentityModel.Logging.dll => 0x9d5fa3ab => 191
	i32 2640706905, ; 412: Azure.Core => 0x9d65fd59 => 173
	i32 2660759594, ; 413: System.Security.Cryptography.ProtectedData.dll => 0x9e97f82a => 207
	i32 2663391936, ; 414: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 210
	i32 2663698177, ; 415: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 416: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 417: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 418: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2677098746, ; 419: Azure.Identity.dll => 0x9f9148fa => 174
	i32 2686887180, ; 420: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 421: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 422: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 270
	i32 2715334215, ; 423: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 424: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 425: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 426: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 427: Xamarin.AndroidX.Activity => 0xa2e0939b => 212
	i32 2735172069, ; 428: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 429: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 218
	i32 2740051746, ; 430: Microsoft.Identity.Client => 0xa351df22 => 187
	i32 2740948882, ; 431: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2748088231, ; 432: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 433: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 322
	i32 2755098380, ; 434: Microsoft.SqlServer.Server.dll => 0xa437770c => 201
	i32 2758225723, ; 435: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 197
	i32 2764765095, ; 436: Microsoft.Maui.dll => 0xa4caf7a7 => 198
	i32 2765824710, ; 437: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 438: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 284
	i32 2778768386, ; 439: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 275
	i32 2779977773, ; 440: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 263
	i32 2785988530, ; 441: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 328
	i32 2788224221, ; 442: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 241
	i32 2801831435, ; 443: Microsoft.Maui.Graphics => 0xa7008e0b => 200
	i32 2803228030, ; 444: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2804509662, ; 445: es/Microsoft.Data.SqlClient.resources.dll => 0xa7296bde => 292
	i32 2806116107, ; 446: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 307
	i32 2810250172, ; 447: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 228
	i32 2819470561, ; 448: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 449: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 450: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 263
	i32 2824502124, ; 451: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 452: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 320
	i32 2838993487, ; 453: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 252
	i32 2841937114, ; 454: it/Microsoft.Data.SqlClient.resources.dll => 0xa96484da => 294
	i32 2849599387, ; 455: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 456: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 275
	i32 2855708567, ; 457: Xamarin.AndroidX.Transition => 0xaa36a797 => 271
	i32 2861098320, ; 458: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 459: Microsoft.Maui.Essentials => 0xaa8a4878 => 199
	i32 2867946736, ; 460: System.Security.Cryptography.ProtectedData => 0xaaf164f0 => 207
	i32 2870099610, ; 461: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 213
	i32 2875164099, ; 462: Jsr305Binding.dll => 0xab5f85c3 => 280
	i32 2875220617, ; 463: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 464: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 239
	i32 2887636118, ; 465: System.Net.dll => 0xac1dd496 => 81
	i32 2899753641, ; 466: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 467: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 468: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 469: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 470: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2916838712, ; 471: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 276
	i32 2919462931, ; 472: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 473: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 215
	i32 2936416060, ; 474: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 475: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 476: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2944313911, ; 477: System.Configuration.ConfigurationManager.dll => 0xaf7eaa37 => 202
	i32 2959614098, ; 478: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 479: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 480: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 481: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 235
	i32 2987532451, ; 482: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 266
	i32 2996846495, ; 483: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 248
	i32 3012788804, ; 484: System.Configuration.ConfigurationManager => 0xb3938244 => 202
	i32 3016983068, ; 485: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 268
	i32 3023353419, ; 486: WindowsBase.dll => 0xb434b64b => 165
	i32 3023511517, ; 487: ru\Microsoft.Data.SqlClient.resources => 0xb4371fdd => 298
	i32 3024354802, ; 488: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 243
	i32 3033605958, ; 489: System.Memory.Data.dll => 0xb4d12746 => 205
	i32 3038032645, ; 490: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 335
	i32 3056245963, ; 491: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 265
	i32 3057625584, ; 492: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 256
	i32 3059408633, ; 493: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 494: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 495: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 496: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 313
	i32 3084678329, ; 497: Microsoft.IdentityModel.Tokens => 0xb7dc74b9 => 194
	i32 3090735792, ; 498: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 499: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 500: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3111772706, ; 501: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 502: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 503: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 504: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3147165239, ; 505: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3148237826, ; 506: GoogleGson.dll => 0xbba64c02 => 175
	i32 3158628304, ; 507: zh-Hant/Microsoft.Data.SqlClient.resources.dll => 0xbc44d7d0 => 300
	i32 3159123045, ; 508: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 509: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 510: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 257
	i32 3192346100, ; 511: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 512: System.Web => 0xbe592c0c => 153
	i32 3204380047, ; 513: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 514: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 515: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 234
	i32 3220365878, ; 516: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 517: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 518: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3258312781, ; 519: Xamarin.AndroidX.CardView => 0xc235e84d => 222
	i32 3265493905, ; 520: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 521: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3268887220, ; 522: fr/Microsoft.Data.SqlClient.resources.dll => 0xc2d742b4 => 293
	i32 3276600297, ; 523: pt-BR/Microsoft.Data.SqlClient.resources.dll => 0xc34cf3e9 => 297
	i32 3277815716, ; 524: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3279906254, ; 525: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 526: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 527: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 528: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 529: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 530: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 308
	i32 3312457198, ; 531: Microsoft.IdentityModel.JsonWebTokens => 0xc57015ee => 190
	i32 3316684772, ; 532: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 533: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 232
	i32 3317144872, ; 534: System.Data => 0xc5b79d28 => 24
	i32 3340431453, ; 535: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 220
	i32 3343947874, ; 536: fr\Microsoft.Data.SqlClient.resources => 0xc7509862 => 293
	i32 3345895724, ; 537: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 261
	i32 3346324047, ; 538: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 258
	i32 3357674450, ; 539: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 325
	i32 3358260929, ; 540: System.Text.Json => 0xc82afec1 => 137
	i32 3362336904, ; 541: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 213
	i32 3362522851, ; 542: Xamarin.AndroidX.Core => 0xc86c06e3 => 229
	i32 3366347497, ; 543: Java.Interop => 0xc8a662e9 => 168
	i32 3374879918, ; 544: Microsoft.IdentityModel.Protocols.dll => 0xc92894ae => 192
	i32 3374999561, ; 545: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 262
	i32 3381016424, ; 546: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 304
	i32 3395150330, ; 547: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3403906625, ; 548: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 549: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 233
	i32 3428513518, ; 550: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 180
	i32 3429136800, ; 551: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 552: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 553: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 236
	i32 3445260447, ; 554: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 555: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 195
	i32 3463511458, ; 556: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 312
	i32 3471940407, ; 557: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 558: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 559: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 325
	i32 3484440000, ; 560: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 324
	i32 3485117614, ; 561: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 562: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 563: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 225
	i32 3509114376, ; 564: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 565: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 566: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 567: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3545306353, ; 568: Microsoft.Data.SqlClient => 0xd35114f1 => 177
	i32 3555084973, ; 569: de\Microsoft.Data.SqlClient.resources => 0xd3e64aad => 291
	i32 3560100363, ; 570: System.Threading.Timer => 0xd432d20b => 147
	i32 3561949811, ; 571: Azure.Core.dll => 0xd44f0a73 => 173
	i32 3562829038, ; 572: Sharing Place => 0xd45c74ee => 0
	i32 3570554715, ; 573: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3570608287, ; 574: System.Runtime.Caching.dll => 0xd4d3289f => 206
	i32 3580758918, ; 575: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 332
	i32 3597029428, ; 576: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 211
	i32 3598340787, ; 577: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 578: System.Linq.dll => 0xd715a361 => 61
	i32 3624195450, ; 579: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 580: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 260
	i32 3633644679, ; 581: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 215
	i32 3638274909, ; 582: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 583: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 246
	i32 3643446276, ; 584: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 329
	i32 3643854240, ; 585: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 257
	i32 3645089577, ; 586: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 587: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 179
	i32 3660523487, ; 588: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3672681054, ; 589: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3682565725, ; 590: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 221
	i32 3684561358, ; 591: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 225
	i32 3697841164, ; 592: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 334
	i32 3700591436, ; 593: Microsoft.IdentityModel.Abstractions.dll => 0xdc928b4c => 189
	i32 3700866549, ; 594: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 595: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 230
	i32 3716563718, ; 596: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 597: Xamarin.AndroidX.Annotation => 0xdda814c6 => 214
	i32 3724971120, ; 598: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 256
	i32 3732100267, ; 599: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 600: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 601: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 602: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3786282454, ; 603: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 223
	i32 3792276235, ; 604: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 605: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 195
	i32 3802395368, ; 606: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3803019198, ; 607: zh-Hans/Microsoft.Data.SqlClient.resources.dll => 0xe2ad77be => 299
	i32 3819260425, ; 608: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3823082795, ; 609: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 610: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 611: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 181
	i32 3844307129, ; 612: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3848348906, ; 613: es\Microsoft.Data.SqlClient.resources => 0xe56124ea => 292
	i32 3849253459, ; 614: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 615: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 616: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 617: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3885497537, ; 618: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 619: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 271
	i32 3888767677, ; 620: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 261
	i32 3889960447, ; 621: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 333
	i32 3896106733, ; 622: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 623: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 229
	i32 3901907137, ; 624: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 625: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 626: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 274
	i32 3928044579, ; 627: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3930554604, ; 628: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 629: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 259
	i32 3945713374, ; 630: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 631: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 632: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 217
	i32 3959773229, ; 633: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 248
	i32 3980434154, ; 634: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 328
	i32 3987592930, ; 635: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 310
	i32 4003436829, ; 636: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4015948917, ; 637: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 216
	i32 4025784931, ; 638: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 639: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 197
	i32 4054681211, ; 640: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4068434129, ; 641: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 642: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4094352644, ; 643: Microsoft.Maui.Essentials.dll => 0xf40add04 => 199
	i32 4099507663, ; 644: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 645: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 646: Xamarin.AndroidX.Emoji2 => 0xf479582c => 237
	i32 4102112229, ; 647: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 323
	i32 4125707920, ; 648: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 318
	i32 4126470640, ; 649: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 180
	i32 4127667938, ; 650: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 651: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 652: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 653: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 330
	i32 4151237749, ; 654: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 655: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 656: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 657: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4181436372, ; 658: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 659: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 253
	i32 4185676441, ; 660: System.Security => 0xf97c5a99 => 130
	i32 4196529839, ; 661: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 662: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 663: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 230
	i32 4257443520, ; 664: ko/Microsoft.Data.SqlClient.resources.dll => 0xfdc36ec0 => 296
	i32 4258378803, ; 665: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 252
	i32 4260525087, ; 666: System.Buffers => 0xfdf2741f => 7
	i32 4263231520, ; 667: System.IdentityModel.Tokens.Jwt.dll => 0xfe1bc020 => 204
	i32 4271975918, ; 668: Microsoft.Maui.Controls.dll => 0xfea12dee => 196
	i32 4274976490, ; 669: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 670: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 253
	i32 4294763496 ; 671: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 239
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [672 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 108, ; 2
	i32 249, ; 3
	i32 283, ; 4
	i32 48, ; 5
	i32 80, ; 6
	i32 145, ; 7
	i32 294, ; 8
	i32 295, ; 9
	i32 30, ; 10
	i32 334, ; 11
	i32 124, ; 12
	i32 200, ; 13
	i32 102, ; 14
	i32 267, ; 15
	i32 107, ; 16
	i32 267, ; 17
	i32 139, ; 18
	i32 287, ; 19
	i32 295, ; 20
	i32 77, ; 21
	i32 124, ; 22
	i32 13, ; 23
	i32 223, ; 24
	i32 298, ; 25
	i32 132, ; 26
	i32 0, ; 27
	i32 269, ; 28
	i32 151, ; 29
	i32 331, ; 30
	i32 332, ; 31
	i32 18, ; 32
	i32 221, ; 33
	i32 26, ; 34
	i32 243, ; 35
	i32 1, ; 36
	i32 59, ; 37
	i32 42, ; 38
	i32 91, ; 39
	i32 226, ; 40
	i32 299, ; 41
	i32 147, ; 42
	i32 245, ; 43
	i32 242, ; 44
	i32 303, ; 45
	i32 54, ; 46
	i32 69, ; 47
	i32 331, ; 48
	i32 212, ; 49
	i32 83, ; 50
	i32 201, ; 51
	i32 316, ; 52
	i32 244, ; 53
	i32 315, ; 54
	i32 131, ; 55
	i32 55, ; 56
	i32 149, ; 57
	i32 74, ; 58
	i32 145, ; 59
	i32 62, ; 60
	i32 146, ; 61
	i32 335, ; 62
	i32 165, ; 63
	i32 327, ; 64
	i32 227, ; 65
	i32 12, ; 66
	i32 240, ; 67
	i32 125, ; 68
	i32 152, ; 69
	i32 113, ; 70
	i32 166, ; 71
	i32 164, ; 72
	i32 242, ; 73
	i32 189, ; 74
	i32 255, ; 75
	i32 84, ; 76
	i32 314, ; 77
	i32 308, ; 78
	i32 186, ; 79
	i32 150, ; 80
	i32 287, ; 81
	i32 60, ; 82
	i32 182, ; 83
	i32 51, ; 84
	i32 103, ; 85
	i32 114, ; 86
	i32 176, ; 87
	i32 40, ; 88
	i32 280, ; 89
	i32 278, ; 90
	i32 120, ; 91
	i32 322, ; 92
	i32 52, ; 93
	i32 44, ; 94
	i32 119, ; 95
	i32 232, ; 96
	i32 320, ; 97
	i32 238, ; 98
	i32 81, ; 99
	i32 136, ; 100
	i32 274, ; 101
	i32 219, ; 102
	i32 8, ; 103
	i32 73, ; 104
	i32 302, ; 105
	i32 155, ; 106
	i32 289, ; 107
	i32 154, ; 108
	i32 92, ; 109
	i32 284, ; 110
	i32 45, ; 111
	i32 317, ; 112
	i32 305, ; 113
	i32 288, ; 114
	i32 109, ; 115
	i32 129, ; 116
	i32 25, ; 117
	i32 209, ; 118
	i32 72, ; 119
	i32 55, ; 120
	i32 46, ; 121
	i32 326, ; 122
	i32 185, ; 123
	i32 233, ; 124
	i32 22, ; 125
	i32 247, ; 126
	i32 86, ; 127
	i32 43, ; 128
	i32 160, ; 129
	i32 71, ; 130
	i32 260, ; 131
	i32 3, ; 132
	i32 42, ; 133
	i32 63, ; 134
	i32 16, ; 135
	i32 53, ; 136
	i32 329, ; 137
	i32 283, ; 138
	i32 105, ; 139
	i32 288, ; 140
	i32 281, ; 141
	i32 244, ; 142
	i32 34, ; 143
	i32 158, ; 144
	i32 85, ; 145
	i32 32, ; 146
	i32 12, ; 147
	i32 51, ; 148
	i32 56, ; 149
	i32 264, ; 150
	i32 36, ; 151
	i32 181, ; 152
	i32 304, ; 153
	i32 282, ; 154
	i32 217, ; 155
	i32 35, ; 156
	i32 58, ; 157
	i32 291, ; 158
	i32 251, ; 159
	i32 188, ; 160
	i32 175, ; 161
	i32 17, ; 162
	i32 285, ; 163
	i32 203, ; 164
	i32 164, ; 165
	i32 317, ; 166
	i32 250, ; 167
	i32 184, ; 168
	i32 177, ; 169
	i32 277, ; 170
	i32 323, ; 171
	i32 153, ; 172
	i32 273, ; 173
	i32 258, ; 174
	i32 321, ; 175
	i32 219, ; 176
	i32 29, ; 177
	i32 52, ; 178
	i32 319, ; 179
	i32 278, ; 180
	i32 5, ; 181
	i32 303, ; 182
	i32 268, ; 183
	i32 272, ; 184
	i32 224, ; 185
	i32 289, ; 186
	i32 216, ; 187
	i32 235, ; 188
	i32 85, ; 189
	i32 277, ; 190
	i32 61, ; 191
	i32 112, ; 192
	i32 57, ; 193
	i32 333, ; 194
	i32 264, ; 195
	i32 99, ; 196
	i32 19, ; 197
	i32 228, ; 198
	i32 111, ; 199
	i32 101, ; 200
	i32 102, ; 201
	i32 301, ; 202
	i32 104, ; 203
	i32 281, ; 204
	i32 71, ; 205
	i32 38, ; 206
	i32 32, ; 207
	i32 103, ; 208
	i32 73, ; 209
	i32 204, ; 210
	i32 307, ; 211
	i32 9, ; 212
	i32 123, ; 213
	i32 46, ; 214
	i32 218, ; 215
	i32 186, ; 216
	i32 9, ; 217
	i32 43, ; 218
	i32 4, ; 219
	i32 265, ; 220
	i32 311, ; 221
	i32 190, ; 222
	i32 306, ; 223
	i32 31, ; 224
	i32 138, ; 225
	i32 92, ; 226
	i32 93, ; 227
	i32 326, ; 228
	i32 206, ; 229
	i32 49, ; 230
	i32 141, ; 231
	i32 112, ; 232
	i32 140, ; 233
	i32 174, ; 234
	i32 234, ; 235
	i32 115, ; 236
	i32 300, ; 237
	i32 282, ; 238
	i32 157, ; 239
	i32 76, ; 240
	i32 79, ; 241
	i32 254, ; 242
	i32 37, ; 243
	i32 276, ; 244
	i32 193, ; 245
	i32 238, ; 246
	i32 231, ; 247
	i32 64, ; 248
	i32 138, ; 249
	i32 15, ; 250
	i32 116, ; 251
	i32 270, ; 252
	i32 279, ; 253
	i32 226, ; 254
	i32 48, ; 255
	i32 70, ; 256
	i32 80, ; 257
	i32 126, ; 258
	i32 94, ; 259
	i32 121, ; 260
	i32 286, ; 261
	i32 26, ; 262
	i32 247, ; 263
	i32 97, ; 264
	i32 28, ; 265
	i32 222, ; 266
	i32 324, ; 267
	i32 302, ; 268
	i32 149, ; 269
	i32 169, ; 270
	i32 4, ; 271
	i32 98, ; 272
	i32 33, ; 273
	i32 93, ; 274
	i32 269, ; 275
	i32 182, ; 276
	i32 21, ; 277
	i32 41, ; 278
	i32 170, ; 279
	i32 318, ; 280
	i32 240, ; 281
	i32 310, ; 282
	i32 187, ; 283
	i32 176, ; 284
	i32 254, ; 285
	i32 285, ; 286
	i32 279, ; 287
	i32 259, ; 288
	i32 2, ; 289
	i32 134, ; 290
	i32 111, ; 291
	i32 183, ; 292
	i32 330, ; 293
	i32 209, ; 294
	i32 327, ; 295
	i32 58, ; 296
	i32 95, ; 297
	i32 193, ; 298
	i32 309, ; 299
	i32 39, ; 300
	i32 220, ; 301
	i32 25, ; 302
	i32 94, ; 303
	i32 89, ; 304
	i32 99, ; 305
	i32 10, ; 306
	i32 87, ; 307
	i32 100, ; 308
	i32 266, ; 309
	i32 178, ; 310
	i32 286, ; 311
	i32 211, ; 312
	i32 194, ; 313
	i32 306, ; 314
	i32 7, ; 315
	i32 251, ; 316
	i32 301, ; 317
	i32 208, ; 318
	i32 188, ; 319
	i32 88, ; 320
	i32 246, ; 321
	i32 154, ; 322
	i32 305, ; 323
	i32 33, ; 324
	i32 116, ; 325
	i32 82, ; 326
	i32 20, ; 327
	i32 11, ; 328
	i32 162, ; 329
	i32 3, ; 330
	i32 198, ; 331
	i32 313, ; 332
	i32 185, ; 333
	i32 183, ; 334
	i32 84, ; 335
	i32 290, ; 336
	i32 64, ; 337
	i32 315, ; 338
	i32 273, ; 339
	i32 143, ; 340
	i32 297, ; 341
	i32 255, ; 342
	i32 157, ; 343
	i32 192, ; 344
	i32 41, ; 345
	i32 117, ; 346
	i32 179, ; 347
	i32 210, ; 348
	i32 309, ; 349
	i32 262, ; 350
	i32 131, ; 351
	i32 75, ; 352
	i32 66, ; 353
	i32 319, ; 354
	i32 172, ; 355
	i32 296, ; 356
	i32 214, ; 357
	i32 143, ; 358
	i32 106, ; 359
	i32 151, ; 360
	i32 70, ; 361
	i32 156, ; 362
	i32 191, ; 363
	i32 178, ; 364
	i32 121, ; 365
	i32 127, ; 366
	i32 314, ; 367
	i32 152, ; 368
	i32 237, ; 369
	i32 141, ; 370
	i32 224, ; 371
	i32 311, ; 372
	i32 20, ; 373
	i32 14, ; 374
	i32 135, ; 375
	i32 75, ; 376
	i32 59, ; 377
	i32 227, ; 378
	i32 167, ; 379
	i32 168, ; 380
	i32 196, ; 381
	i32 15, ; 382
	i32 74, ; 383
	i32 6, ; 384
	i32 23, ; 385
	i32 249, ; 386
	i32 203, ; 387
	i32 208, ; 388
	i32 91, ; 389
	i32 312, ; 390
	i32 1, ; 391
	i32 136, ; 392
	i32 250, ; 393
	i32 272, ; 394
	i32 134, ; 395
	i32 69, ; 396
	i32 146, ; 397
	i32 321, ; 398
	i32 290, ; 399
	i32 241, ; 400
	i32 184, ; 401
	i32 88, ; 402
	i32 96, ; 403
	i32 231, ; 404
	i32 236, ; 405
	i32 316, ; 406
	i32 31, ; 407
	i32 205, ; 408
	i32 45, ; 409
	i32 245, ; 410
	i32 191, ; 411
	i32 173, ; 412
	i32 207, ; 413
	i32 210, ; 414
	i32 109, ; 415
	i32 158, ; 416
	i32 35, ; 417
	i32 22, ; 418
	i32 174, ; 419
	i32 114, ; 420
	i32 57, ; 421
	i32 270, ; 422
	i32 144, ; 423
	i32 118, ; 424
	i32 120, ; 425
	i32 110, ; 426
	i32 212, ; 427
	i32 139, ; 428
	i32 218, ; 429
	i32 187, ; 430
	i32 54, ; 431
	i32 105, ; 432
	i32 322, ; 433
	i32 201, ; 434
	i32 197, ; 435
	i32 198, ; 436
	i32 133, ; 437
	i32 284, ; 438
	i32 275, ; 439
	i32 263, ; 440
	i32 328, ; 441
	i32 241, ; 442
	i32 200, ; 443
	i32 159, ; 444
	i32 292, ; 445
	i32 307, ; 446
	i32 228, ; 447
	i32 163, ; 448
	i32 132, ; 449
	i32 263, ; 450
	i32 161, ; 451
	i32 320, ; 452
	i32 252, ; 453
	i32 294, ; 454
	i32 140, ; 455
	i32 275, ; 456
	i32 271, ; 457
	i32 169, ; 458
	i32 199, ; 459
	i32 207, ; 460
	i32 213, ; 461
	i32 280, ; 462
	i32 40, ; 463
	i32 239, ; 464
	i32 81, ; 465
	i32 56, ; 466
	i32 37, ; 467
	i32 97, ; 468
	i32 166, ; 469
	i32 172, ; 470
	i32 276, ; 471
	i32 82, ; 472
	i32 215, ; 473
	i32 98, ; 474
	i32 30, ; 475
	i32 159, ; 476
	i32 202, ; 477
	i32 18, ; 478
	i32 127, ; 479
	i32 119, ; 480
	i32 235, ; 481
	i32 266, ; 482
	i32 248, ; 483
	i32 202, ; 484
	i32 268, ; 485
	i32 165, ; 486
	i32 298, ; 487
	i32 243, ; 488
	i32 205, ; 489
	i32 335, ; 490
	i32 265, ; 491
	i32 256, ; 492
	i32 170, ; 493
	i32 16, ; 494
	i32 144, ; 495
	i32 313, ; 496
	i32 194, ; 497
	i32 125, ; 498
	i32 118, ; 499
	i32 38, ; 500
	i32 115, ; 501
	i32 47, ; 502
	i32 142, ; 503
	i32 117, ; 504
	i32 34, ; 505
	i32 175, ; 506
	i32 300, ; 507
	i32 95, ; 508
	i32 53, ; 509
	i32 257, ; 510
	i32 129, ; 511
	i32 153, ; 512
	i32 24, ; 513
	i32 161, ; 514
	i32 234, ; 515
	i32 148, ; 516
	i32 104, ; 517
	i32 89, ; 518
	i32 222, ; 519
	i32 60, ; 520
	i32 142, ; 521
	i32 293, ; 522
	i32 297, ; 523
	i32 100, ; 524
	i32 5, ; 525
	i32 13, ; 526
	i32 122, ; 527
	i32 135, ; 528
	i32 28, ; 529
	i32 308, ; 530
	i32 190, ; 531
	i32 72, ; 532
	i32 232, ; 533
	i32 24, ; 534
	i32 220, ; 535
	i32 293, ; 536
	i32 261, ; 537
	i32 258, ; 538
	i32 325, ; 539
	i32 137, ; 540
	i32 213, ; 541
	i32 229, ; 542
	i32 168, ; 543
	i32 192, ; 544
	i32 262, ; 545
	i32 304, ; 546
	i32 101, ; 547
	i32 123, ; 548
	i32 233, ; 549
	i32 180, ; 550
	i32 163, ; 551
	i32 167, ; 552
	i32 236, ; 553
	i32 39, ; 554
	i32 195, ; 555
	i32 312, ; 556
	i32 17, ; 557
	i32 171, ; 558
	i32 325, ; 559
	i32 324, ; 560
	i32 137, ; 561
	i32 150, ; 562
	i32 225, ; 563
	i32 155, ; 564
	i32 130, ; 565
	i32 19, ; 566
	i32 65, ; 567
	i32 177, ; 568
	i32 291, ; 569
	i32 147, ; 570
	i32 173, ; 571
	i32 0, ; 572
	i32 47, ; 573
	i32 206, ; 574
	i32 332, ; 575
	i32 211, ; 576
	i32 79, ; 577
	i32 61, ; 578
	i32 106, ; 579
	i32 260, ; 580
	i32 215, ; 581
	i32 49, ; 582
	i32 246, ; 583
	i32 329, ; 584
	i32 257, ; 585
	i32 14, ; 586
	i32 179, ; 587
	i32 68, ; 588
	i32 171, ; 589
	i32 221, ; 590
	i32 225, ; 591
	i32 334, ; 592
	i32 189, ; 593
	i32 78, ; 594
	i32 230, ; 595
	i32 108, ; 596
	i32 214, ; 597
	i32 256, ; 598
	i32 67, ; 599
	i32 63, ; 600
	i32 27, ; 601
	i32 160, ; 602
	i32 223, ; 603
	i32 10, ; 604
	i32 195, ; 605
	i32 11, ; 606
	i32 299, ; 607
	i32 78, ; 608
	i32 126, ; 609
	i32 83, ; 610
	i32 181, ; 611
	i32 66, ; 612
	i32 292, ; 613
	i32 107, ; 614
	i32 65, ; 615
	i32 128, ; 616
	i32 122, ; 617
	i32 77, ; 618
	i32 271, ; 619
	i32 261, ; 620
	i32 333, ; 621
	i32 8, ; 622
	i32 229, ; 623
	i32 2, ; 624
	i32 44, ; 625
	i32 274, ; 626
	i32 156, ; 627
	i32 128, ; 628
	i32 259, ; 629
	i32 23, ; 630
	i32 133, ; 631
	i32 217, ; 632
	i32 248, ; 633
	i32 328, ; 634
	i32 310, ; 635
	i32 29, ; 636
	i32 216, ; 637
	i32 62, ; 638
	i32 197, ; 639
	i32 90, ; 640
	i32 87, ; 641
	i32 148, ; 642
	i32 199, ; 643
	i32 36, ; 644
	i32 86, ; 645
	i32 237, ; 646
	i32 323, ; 647
	i32 318, ; 648
	i32 180, ; 649
	i32 50, ; 650
	i32 6, ; 651
	i32 90, ; 652
	i32 330, ; 653
	i32 21, ; 654
	i32 162, ; 655
	i32 96, ; 656
	i32 50, ; 657
	i32 113, ; 658
	i32 253, ; 659
	i32 130, ; 660
	i32 76, ; 661
	i32 27, ; 662
	i32 230, ; 663
	i32 296, ; 664
	i32 252, ; 665
	i32 7, ; 666
	i32 204, ; 667
	i32 196, ; 668
	i32 110, ; 669
	i32 253, ; 670
	i32 239 ; 671
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
