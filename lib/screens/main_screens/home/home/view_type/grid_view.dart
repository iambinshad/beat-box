import 'package:beatabox/controller/get_all_song_controller.dart';
import 'package:beatabox/provider/lyrics_provider.dart';
import 'package:beatabox/screens/main_screens/home/home/home_screen.dart';
import 'package:beatabox/screens/mini_screens/tabs/tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/songmodel_provider.dart';
import '../../../../mini_screens/tabs/now_playing_screen.dart';
import '../../menu_button.dart';

class GridViewType extends StatelessWidget {
  const GridViewType({Key? key, required this.allSongs, required this.items})
      : super(key: key);

  final List<SongModel> allSongs;
  final items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / 1.1),
            crossAxisSpacing: 2,
            mainAxisSpacing: 10),
        itemCount: items.data!.length,
        itemBuilder: ((context, index) {
          allSongs.addAll(items.data!);
          return GestureDetector(
            onTap: () {
              // playSong(item.data![index].uri);
              context.read<LyricsProvider>().callLyricsApiService(
                  items.data![index].artist ?? "", items.data![index].title);

              context.read<SongModelProvider>().setId(items.data![index].id);
              GetAllSongController.audioPlayer.setAudioSource(
                  GetAllSongController.createSongList(items.data!),
                  initialIndex: index);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NowPlayingScreen(
                    songModelList: items.data!,
                    count: items.data!.length,
                  );
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 111, 111, 193))),
                child: GridTile(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FavOrPlayMenuButton(
                          songFavorite: startSong[index], findex: index),
                    ],
                  ),
                  footer: Container(
                    decoration: const BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.black,

                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22)),
                        color: Colors.black26),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 15),
                          child: Text(
                            items.data![index].displayNameWOExt,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: QueryArtworkWidget(
                    errorBuilder: (p0, p1, p2) {
                      return const CircularProgressIndicator();
                    },
                    artworkWidth: 100,
                    artworkHeight: 100,
                    artworkFit: BoxFit.fill,
                    nullArtworkWidget: Image.asset(
                      'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png',
                  
                    ),
                    id: items.data![index].id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
