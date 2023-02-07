import 'package:beatabox/screens/mini_screens/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../controller/get_all_song_controller.dart';
import '../../../provider/songmodel_provider.dart';
import '../favorites/favorite_notifying.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<SongModel> allsongs = [];
List<SongModel> foundSongs = [];
final audioPlayer = AudioPlayer();
final audioQuery = OnAudioQuery();

@override
class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    songsLoading();
    super.initState();
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(enteredText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundSongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => updateList(value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff302360),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          hintText: 'Search Song',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          prefixIconColor: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // const Text(
                  //   '   Results',
                  //   style:
                  //       TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  // ),
                  foundSongs.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(7),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 111, 111, 193),
                                    ),
                                    color: Colors.black12),
                                child: ListTile(
                                  iconColor: Colors.white,
                                  selectedColor: Colors.purpleAccent,
                                  leading: QueryArtworkWidget(
                                      id: foundSongs[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 27,
                                          backgroundImage: AssetImage(
                                              'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png'))),
                                  title: Text(
                                    foundSongs[index].displayNameWOExt,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'poppins',
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    foundSongs[index].artist.toString() ==
                                            "<unknown>"
                                        ? "Unknown Artist"
                                        : foundSongs[index].artist.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 12,
                                        color: Colors.blueGrey),
                                  ),
                                  trailing: FavButMusicPlaying(
                                    songFavoriteMusicPlaying: foundSongs[index],
                                  ),
                                  onTap: () {
                                    GetAllSongController.audioPlayer
                                        .setAudioSource(
                                            GetAllSongController.createSongList(
                                                foundSongs),
                                            initialIndex: index);
                                    GetAllSongController.audioPlayer.play();
                                    context
                                        .read<SongModelProvider>()
                                        .setId(foundSongs[index].id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return NowPlayingScreen(
                                        songModelList: foundSongs,
                                      );
                                    }));
                                  },
                                ),
                              ),
                            );
                          }),
                          itemCount: foundSongs.length,
                        ))
                      : Center(
                          child: Lottie.asset(
                              'assets/lottie/68796-empty-search.json'),
                        )
                ],
              )),
            ),
          )),
    );
  }

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    foundSongs = allsongs;
  }
}
