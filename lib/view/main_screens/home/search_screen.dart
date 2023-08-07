import 'package:beatabox/provider/home_page_provider/search_provider.dart';
import 'package:beatabox/view/mini_screens/tabs/now_playing_screen.dart';
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

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
var searchProvider = Provider.of<SearchProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchProvider>(context,listen: false).foundSongs=allsongs;
      songsLoading(searchProvider);
      Provider.of<SearchProvider>(context,listen: false).foundSongs= allsongs;
      
    });
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
                    child: Consumer<SearchProvider>(
                      builder: (context, values, child) => TextField(
                        onChanged: (value) => values.updateList(value),
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  searchProvider.foundSongs.isNotEmpty
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
                                      id: searchProvider.foundSongs[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 27,
                                          backgroundImage: AssetImage(
                                              'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png'))),
                                  title: Text(
                                    searchProvider.foundSongs[index].displayNameWOExt,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'poppins',
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    searchProvider.foundSongs[index].artist.toString() ==
                                            "<unknown>"
                                        ? "Unknown Artist"
                                        : searchProvider.foundSongs[index].artist.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 12,
                                        color: Colors.blueGrey),
                                  ),
                                  trailing: FavButMusicPlaying(
                                    songFavoriteMusicPlaying: searchProvider.foundSongs[index],
                                  ),
                                  onTap: () {
                                    GetAllSongController.audioPlayer
                                        .setAudioSource(
                                            GetAllSongController.createSongList(
                                                searchProvider.foundSongs),
                                            initialIndex: index);
                                    GetAllSongController.audioPlayer.play();
                                    context
                                        .read<SongModelProvider>()
                                        .setId(searchProvider.foundSongs[index].id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return NowPlayingScreen(
                                        songModelList: searchProvider.foundSongs,
                                      );
                                    }));
                                  },
                                ),
                              ),
                            );
                          }),
                          itemCount: searchProvider.foundSongs.length,
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

  void songsLoading(searchProvider) async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    searchProvider.foundSongs = allsongs;
  }
}
List<SongModel> allsongs = [];
final audioPlayer = AudioPlayer();
final audioQuery = OnAudioQuery();
