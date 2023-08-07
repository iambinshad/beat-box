import 'package:beatabox/view/main_screens/playlist/songs_add_scrn.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../controller/get_all_song_controller.dart';
import '../../mini_screens/tabs/now_playing_screen.dart';
import '../../../model/fav_model.dart';
import '../../../provider/songmodel_provider.dart';
import 'package:provider/provider.dart';

class PlaylistSongs extends StatelessWidget {
  final FavModel playlist;
  final int findex;

  const PlaylistSongs(
      {super.key, required this.playlist, required this.findex});

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        Colors.deepPurple,
        Colors.black,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        playlist.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'poppins'),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SongListAddPage(
                              playlist: playlist,
                            );
                          },
                        ));
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color.fromARGB(255, 111, 111, 193),
                            ),
                            color: Colors.black12),
                        child: const Center(
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Positioned(
                                    child: Opacity(
                                  opacity: 0.1,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 27,
                                  ),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(left: 9, top: 9),
                                  child: Icon(
                                    Icons.add,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            title: Text(
                              'Add Songs',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<FavModel>('playlistDb').listenable(),
                              builder: (BuildContext context,
                                  Box<FavModel> music, Widget? child) {
                                songPlaylist = listPlaylist(
                                    music.values.toList()[findex].songId);
                                return songPlaylist.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'Add Some Songs',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'poppins'),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemBuilder: ((context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 111, 111, 193),
                                                  ),
                                                  color: Colors.black12),
                                              child: ListTile(
                                                iconColor: Colors.white,
                                                selectedColor:
                                                    Colors.purpleAccent,
                                                leading: QueryArtworkWidget(
                                                    id: songPlaylist[index].id,
                                                    type: ArtworkType.AUDIO,
                                                    nullArtworkWidget:
                                                        const CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            radius: 27,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png'))),
                                                title: Text(
                                                  songPlaylist[index].title,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'poppins',
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(
                                                  songPlaylist[index].artist!,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      fontSize: 12,
                                                      color: Colors.blueGrey),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    // widget.playlist.deleteData(
                                                    //     songPlaylist[index].id);
                                                    deletePlaylistSongs(
                                                        context,
                                                        music,
                                                        index,
                                                        songPlaylist);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                                onTap: () {
                                                  List<SongModel> newMusicList =
                                                      [...songPlaylist];
                                                  GetAllSongController
                                                      .audioPlayer
                                                      .stop();
                                                  GetAllSongController
                                                      .audioPlayer
                                                      .setAudioSource(
                                                          GetAllSongController
                                                              .createSongList(
                                                                  newMusicList),
                                                          initialIndex: index);

                                                  context
                                                      .read<SongModelProvider>()
                                                      .setId(newMusicList[index]
                                                          .id);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return NowPlayingScreen(
                                                      songModelList:
                                                          songPlaylist,
                                                      count:
                                                          newMusicList.length,
                                                    );
                                                  }));
                                                },
                                              ),
                                            ),
                                          );
                                        }),
                                        itemCount: songPlaylist.length,
                                      );
                              })),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deletePlaylistSongs(
      BuildContext context, Box<FavModel> musicList, int index, songplaylist) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 52, 6, 105),
          title: const Text(
            'Delete song',
            style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          ),
          content: const Text(
              'Are you sure you want to delete this song from  playlist?',
              style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No',
                  style: TextStyle(
                      color: Colors.purpleAccent, fontFamily: 'poppins')),
            ),
            ElevatedButton(
              onPressed: () {
                playlist.deleteData(songplaylist[index].id);
                Navigator.pop(context);
                const snackBar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    'song is deleted',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('Yes',
                  style: TextStyle(
                      color: Colors.purpleAccent, fontFamily: 'poppins')),
            ),
          ],
        );
      },
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
