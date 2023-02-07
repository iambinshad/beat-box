import 'package:beatabox/screens/mini_screens/now_playing_screen.dart';
import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../../controller/get_all_song_controller.dart';
import '../../../database/fav_db.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder:
            (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black,
              Colors.deepPurple,
              Colors.black,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: const Text(
                    'Favourite songs',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'poppins'),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ValueListenableBuilder(
                                valueListenable: FavoriteDb.favoriteSongs,
                                builder: (BuildContext ctx,
                                    List<SongModel> favoriteData,
                                    Widget? child) {
                                  if (favoriteData.isEmpty) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.only(top: 70, left: 10),
                                      child: Center(
                                        child: Text(
                                          'No Favorite Songs',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                        height: 400,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, right: 6),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 111, 111, 193),
                                                      ),
                                                      color: Colors.black12),
                                                  child: ListTile(
                                                    iconColor: Colors.white,
                                                    selectedColor:
                                                        Colors.purpleAccent,
                                                    leading: QueryArtworkWidget(
                                                        id: favoriteData[index]
                                                            .id,
                                                        type: ArtworkType.AUDIO,
                                                        nullArtworkWidget:
                                                            const CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 27,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                  'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                                                                ))),
                                                    title: Text(
                                                      favoriteData[index]
                                                          .displayNameWOExt,
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'poppins',
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      favoriteData[index]
                                                          .artist
                                                          .toString(),
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: 'poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                        Icons.heart_broken,
                                                        color: Colors.purple,
                                                      ),
                                                      onPressed: () {
                                                        FavoriteDb.favoriteSongs
                                                            .notifyListeners();
                                                        FavoriteDb.delete(
                                                            favoriteData[index]
                                                                .id);
                                                        const snackbar =
                                                            SnackBar(
                                                          content: Text(
                                                            'Song Deleted From your Favourites',
                                                          ),
                                                          duration: Duration(
                                                              seconds: 1),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  20,
                                                                  5,
                                                                  46),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackbar);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      List<SongModel>
                                                          favoriteList = [
                                                        ...favoriteData
                                                      ];
                                                      GetAllSongController
                                                          .audioPlayer
                                                          .stop();
                                                      GetAllSongController
                                                          .audioPlayer
                                                          .setAudioSource(
                                                              GetAllSongController
                                                                  .createSongList(
                                                                      favoriteList),
                                                              initialIndex:
                                                                  index);
                                                      GetAllSongController
                                                          .audioPlayer
                                                          .play();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NowPlayingScreen(
                                                                    songModelList:
                                                                        favoriteList),
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                          itemCount: favoriteData.length,
                                        ));
                                  }
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
