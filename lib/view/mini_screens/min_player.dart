import 'package:beatabox/controller/get_all_song_controller.dart';
import 'package:beatabox/view/mini_screens/tabs/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
   const MiniPlayer({
    Key? key,
   
  }) : super(key: key);
  // final VoidCallback openContainer;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool firstSong = false;
bool isPlaying = false;

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NowPlayingScreen(songModelList:GetAllSongController.playingSong!),)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color:  Colors.black
                ),
                gradient:const LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter, colors: [
                  Color.fromARGB(255, 92, 53, 158),Colors.black,Color.fromARGB(255, 92, 53, 158)
                ])
               
            
                ),
            height: 60,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    width: size.width * 0.95,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            width: size.width * 0.5,
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<bool>(
                                  stream: GetAllSongController
                                      .audioPlayer.playingStream,
                                  builder: (context, snapshot) {
                                    bool? playingStage = snapshot.data;
                                    if (playingStage != null && playingStage) {
                                      return TextScroll(
                                        GetAllSongController
                                            .playingSong![GetAllSongController
                                                .audioPlayer.currentIndex!]
                                            .displayNameWOExt,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 14),
                                      );
                                    } else {
                                      return Text(
                                        GetAllSongController
                                            .playingSong![GetAllSongController
                                                .audioPlayer.currentIndex!]
                                            .displayNameWOExt,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 14),
                                      );
                                    }
                                  },
                                ),
                                TextScroll(
                                  GetAllSongController
                                              .playingSong![GetAllSongController
                                                  .audioPlayer.currentIndex!]
                                              .artist
                                              .toString() ==
                                          "<unknown>"
                                      ? "Unknown Artist"
                                      : GetAllSongController
                                          .playingSong![GetAllSongController
                                              .audioPlayer.currentIndex!]
                                          .artist
                                          .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 10,
                                      color: Colors.blueGrey),
                                  mode: TextScrollMode.endless,
                                ),
                              ],
                            ),
                          ),
                          firstSong
                              ? const SizedBox(
                                  width: 45,
                                )
                              : IconButton(
                                  iconSize: 32,
                                  onPressed: () async {
                                    if (GetAllSongController
                                        .audioPlayer.hasPrevious) {
                                      await GetAllSongController.audioPlayer
                                          .seekToPrevious();
                                      await GetAllSongController.audioPlayer
                                          .play();
                                    } else {
                                      await GetAllSongController.audioPlayer
                                          .play();
                                    }
                                  },
                                  icon: const Icon(Icons.skip_previous),
                                  color: GetAllSongController
                                          .audioPlayer.hasPrevious
                                      ? Colors.white
                                      : const Color.fromARGB(255, 94, 51, 51),
                                ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 2, 3, 61),
                                shape: const CircleBorder()),
                            onPressed: () async {
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                              if (GetAllSongController.audioPlayer.playing) {
                                await GetAllSongController.audioPlayer.pause();
                                setState(() {});
                              } else {
                                await GetAllSongController.audioPlayer.play();
                                setState(() {});
                              }
                            },
                            child: StreamBuilder<bool>(
                              stream: GetAllSongController
                                  .audioPlayer.playingStream,
                              builder: (context, snapshot) {
                                bool? playingStage = snapshot.data;
                                if (playingStage != null && playingStage) {
                                  return const Icon(
                                    Icons.pause_circle,
                                    color: Colors.white,
                                    size: 35,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                    size: 35,
                                  );
                                }
                              },
                            ),
                          ),
                          IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              if (GetAllSongController.audioPlayer.hasNext) {
                                await GetAllSongController.audioPlayer
                                    .seekToNext();
                                await GetAllSongController.audioPlayer.play();
                              } else {
                                await GetAllSongController.audioPlayer.play();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 32,
                            ),
                            color: GetAllSongController.audioPlayer.hasNext
                                ? Colors.white
                                : const Color.fromARGB(255, 96, 96, 96),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
