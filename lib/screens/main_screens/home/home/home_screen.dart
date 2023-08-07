// import 'dart:developer';

// import 'package:beatabox/provider/home_page_provider/home_provider.dart';
// import 'package:beatabox/provider/mini_player_provider/mini_player_prov.dart';
// import 'package:beatabox/view/main_screens/home/home/view_type/grid_view.dart';
// import 'package:beatabox/view/main_screens/home/menu_button.dart';
// import 'package:beatabox/view/main_screens/home/search_screen.dart';
// import 'package:beatabox/view/mini_screens/mini_player.dart';
// import 'package:beatabox/view/mini_screens/tabs/now_playing_screen.dart';
// // import 'package:beatabox/screens/main_screens/home/home/view_type/grid_view.dart';
// // import 'package:beatabox/screens/main_screens/home/search_screen.dart';
// // import 'package:beatabox/screens/mini_screens/mini_player.dart';
// // import 'package:beatabox/screens/mini_screens/now_playing_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import 'package:provider/provider.dart';

// import '../../../../controller/get_all_song_controller.dart';
// import '../../../../database/fav_db.dart';
// import '../../../../provider/songmodel_provider.dart';
// // import '../menu_button.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   final AudioPlayer _audioPlayer = AudioPlayer();

//   List<SongModel> allSongs = [];

//   void playSong(String? uri) {
//     try {
//       _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
//       _audioPlayer.play();
//     } on Exception {
//       log('Error parsing Song');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       GetAllSongController.audioPlayer.currentIndexStream.listen((index) {});
//     });
//     return WillPopScope(
//       onWillPop: () {
//         _onButtonPressed(context);
//         return Future.value(false);
//       },
//       child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Colors.black,
//           Colors.deepPurple,
//           Colors.black,
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         child: Scaffold(
//             appBar: AppBar(
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Consumer<HomePageProvider>(
//                   builder: (context, value, child) => IconButton(
//                     onPressed: () {
//                       value.viewtype();
//                     },
//                     icon: Icon(value.isGridveiw
//                         ? Icons.grid_view_rounded
//                         : Icons.list_rounded),
//                     iconSize: 28,
//                   ),
//                 ),
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: SizedBox(
//                     width: 90,
//                     child: IconButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return const SearchScreen();
//                             },
//                           ));
//                         },
//                         icon: const Icon(
//                           Icons.search_outlined,
//                           size: 30,
//                         )),
//                   ),
//                 )
//               ],
//               automaticallyImplyLeading: false,
//               centerTitle: true,
//               title: const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: SizedBox(
//                     child: Image(
//                         image: AssetImage(
//                             'assets/home_screen/integrated logo.png'))),
//               ),
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//             ),
//             backgroundColor: Colors.transparent,
//             body: SafeArea(
//               child: Stack(children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       child: Container(
//                           alignment: Alignment.bottomCenter,
//                           // color: Colors.white,
//                           height: 550,
//                           width: double.infinity,
//                           child: FutureBuilder<List<SongModel>>(
//                               future: _audioQuery.querySongs(
//                                   sortType: null,
//                                   orderType: OrderType.ASC_OR_SMALLER,
//                                   uriType: UriType.EXTERNAL),
//                               builder: ((context, items) {
//                                 if (items.data == null) {
//                                   return const Center(
//                                     child: CircularProgressIndicator(),
//                                   );
//                                 }
//                                 if (items.data!.isEmpty) {
//                                   return const Center(
//                                     child: Text(
//                                       'No Songs found',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   );
//                                 }
//                                 startSong = items.data!;
//                                 if (!Provider.of<FavoriteDb>(context)
//                                     .isInitialized) {
//                                   Provider.of<FavoriteDb>(context)
//                                       .initialize(items.data!);
//                                 }
//                                 GetAllSongController.songscopy =
//                                     items.data!; //for playlist

//                                 return Provider.of<HomePageProvider>(context)
//                                         .isGridveiw
//                                     ? listViewType(items)
//                                     : GridViewType(
//                                         allSongs: allSongs,
//                                         items: items,
//                                       );
//                               }))),
//                     ),
//                     Consumer<MiniPlayerProv>(
//                       builder: (context, value, child) => Stack(
//                         children: [
//                           value.isMiniPlayer ? MiniPlayer() : Text(''),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ]),
//             )),
//       ),
//     );
//   }

//   ListView listViewType(AsyncSnapshot<List<SongModel>> items) {
//     return ListView.builder(
//       itemBuilder: ((context, index) {
//         allSongs.addAll(items.data!);
//         return Padding(
//           padding: const EdgeInsets.only(left: 6, right: 6),
//           child: Padding(
//             padding: const EdgeInsets.all(7.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 111, 111, 193),
//                   ),
//                   color: Colors.black12),
//               child: ListTile(
//                 iconColor: Colors.white,
//                 selectedColor: Colors.purpleAccent,
//                 leading: QueryArtworkWidget(
//                     id: items.data![index].id,
//                     type: ArtworkType.AUDIO,
//                     nullArtworkWidget: const CircleAvatar(
//                         backgroundColor: Colors.transparent,
//                         radius: 27,
//                         backgroundImage: AssetImage(
//                             'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png'))),
//                 title: Text(
//                   items.data![index].displayNameWOExt,
//                   style: const TextStyle(
//                       overflow: TextOverflow.ellipsis,
//                       fontFamily: 'poppins',
//                       color: Colors.white),
//                 ),
//                 subtitle: Text(
//                   items.data![index].artist.toString() == "<unknown>"
//                       ? "Unknown Artist"
//                       : items.data![index].artist.toString(),
//                   style: const TextStyle(
//                       overflow: TextOverflow.ellipsis,
//                       fontFamily: 'poppins',
//                       fontSize: 12,
//                       color: Colors.blueGrey),
//                 ),
//                 trailing: FavOrPlayMenuButton(
//                     songFavorite: startSong[index], findex: index),
//                 onTap: () {
//                   GetAllSongController.audioPlayer.setAudioSource(
//                       GetAllSongController.createSongList(items.data!),
//                       initialIndex: index);

//                   context
//                       .read<SongModelProvider>()
//                       .setId(items.data![index].id);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return NowPlayingScreen(
//                       songModelList: items.data!,
//                       count: items.data!.length,
//                     );
//                   }));
//                 },
//               ),
//             ),
//           ),
//         );
//       }),
//       itemCount: items.data!.length,
//     );
//   }

//   Future<bool> _onButtonPressed(BuildContext context) async {
//     bool? exitApp = await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Exit App'),
//             content: const Text('Do you want to close this app?'),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('No',
//                       style:
//                           TextStyle(color: Colors.deepPurple, fontSize: 15))),
//               TextButton(
//                   onPressed: () {
//                     SystemNavigator.pop();
//                   },
//                   child: const Text(
//                     'Yes',
//                     style: TextStyle(color: Colors.deepPurple, fontSize: 15),
//                   ))
//             ],
//           );
//         });
//     return exitApp ?? false;
//   }
// }

// List<SongModel> startSong = [];
