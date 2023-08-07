import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../database/playlist_db.dart';
import '../../../model/fav_model.dart';
import '../home/search_screen.dart';

class SongListAddPage extends StatelessWidget {
  const SongListAddPage({super.key, required this.playlist});
  final FavModel playlist;
  @override
  Widget build(BuildContext context) {
    final playListPro = Provider.of<PlaylistDb>(context);

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
                        const Text(
                          'Add Song To Playlist',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: FutureBuilder<List<SongModel>>(
                                future: audioQuery.querySongs(
                                    sortType: null,
                                    orderType: OrderType.ASC_OR_SMALLER,
                                    uriType: UriType.EXTERNAL,
                                    ignoreCase: true),
                                builder: (context, item) {
                                  if (item.data == null) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (item.data!.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No Song Available',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins'),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
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
                                              selectedColor: Colors
                                                  .purpleAccent,
                                              leading: QueryArtworkWidget(
                                                  id: item.data![index].id,
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
                                                item.data![index]
                                                    .displayNameWOExt,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                '${item.data![index].artist == "<unknown>" ? "Unknown Artist" : item.data![index].artist}',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    color: Colors.blueGrey),
                                              ),
                                              trailing: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Wrap(children: [
                                                  !playlist.isValueIn(
                                                          item.data![index].id)
                                                      ? IconButton(
                                                          onPressed: () {
                                                            songAddPlaylist(
                                                                item.data![
                                                                    index],
                                                                context);
                                                            playListPro
                                                                .notifyListeners();
                                                          },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ))
                                                      : Consumer<PlaylistDb>(
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    playlist.deleteData(item
                                                                        .data![
                                                                            index]
                                                                        .id);
                                                                    value
                                                                        .notifyListeners();

                                                                    const snackBar =
                                                                        SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Song deleted from playlist',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              450),
                                                                    );
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);
                                                                  },
                                                                  icon:
                                                                      const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            25),
                                                                    child: Icon(
                                                                      Icons
                                                                          .minimize,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )),
                                                        )
                                                ]),
                                              )),
                                        ),
                                      );
                                    }),
                                    itemCount: item.data!.length,
                                  );
                                })),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void songAddPlaylist(SongModel data, context) {
    playlist.add(data.id);

    const snackBar1 = SnackBar(
        content: Text(
      'Song added to Playlist',
      style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
  }
}
