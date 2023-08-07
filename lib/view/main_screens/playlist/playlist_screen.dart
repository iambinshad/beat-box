import 'package:beatabox/view/main_screens/playlist/playlist_song_scn.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../database/playlist_db.dart';
import '../../../model/fav_model.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

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
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 56,
                ),
                const Text(
                  'Playlists',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'poppins'),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {
                          newplaylist(context, _formKey);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        )))
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    // height: 400,
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<FavModel>('playlistDb').listenable(),
                        builder: (BuildContext context, Box<FavModel> musicList,
                            Widget? child) {
                          return Hive.box<FavModel>('playlistDb').isEmpty
                              ? Center(
                                  child: SizedBox(
                                    height: 300,
                                    width: 200,
                                    child: InkWell(
                                      highlightColor:
                                          const Color.fromRGBO(0, 0, 0, 0),
                                      onTap: () {
                                        newplaylist(context, _formKey);
                                      },
                                      child: Column(
                                        children: [
                                          Lottie.asset(
                                              'assets/lottie/add-new-playlist.json',
                                              width: 100,
                                              height: 100),
                                          const Text(
                                            'Click to add new Playlist',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                fontFamily: 'poppins'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemBuilder: ((context, index) {
                                    final data =
                                        musicList.values.toList()[index];

                                    // allSongs.addAll(items.data!);
                                    return Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 111, 111, 193),
                                            ),
                                            color: Colors.black12),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 30,
                                                  child: Image.asset(
                                                      'assets/home_screen/Premium_Photo___Headphones_on_dark_black_background-removebg-preview.png'),
                                                ),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    data.name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                        fontFamily: 'poppins'),
                                                  ),
                                                ),
                                                trailing: PopupMenuButton(
                                                  color: const Color.fromARGB(
                                                      255, 66, 20, 119),
                                                  icon: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white,
                                                  ),
                                                  itemBuilder: (context) => [
                                                    const PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'poppins'),
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 2,
                                                      child: Text(
                                                        'delete',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'poppins'),
                                                      ),
                                                    )
                                                  ],
                                                  onSelected: (value) {
                                                    if (value == 1) {
                                                      editPlaylistName(
                                                          context, data, index);
                                                    } else if (value == 2) {
                                                      deletePlaylist(context,
                                                          musicList, index);
                                                    }
                                                  },
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlaylistSongs(
                                                          playlist: data,
                                                          findex: index,
                                                        ),
                                                      ));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  itemCount: musicList.length,
                                );
                        })),
              ),
            )
          ]),
        ),
      ),
    );
  }
}


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

Future<dynamic> editPlaylistName(
    BuildContext context, FavModel data, int index) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 52, 6, 105),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.left,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistName = FavModel(name: name, songId: []);
                    Provider.of<PlaylistDb>(context, listen: false)
                        .editList(index, playlistName);
                  }
                  nameController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<dynamic> deletePlaylist(
    BuildContext context, Box<FavModel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
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
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Playlist is deleted',
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

Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 67, 27, 110),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.left,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.purpleAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  saveButtonPressed(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.purpleAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> saveButtonPressed(context) async {
  final name = nameController.text.trim();
  final music = FavModel(name: name, songId: []);
  final datas = Provider.of<PlaylistDb>(context, listen: false)
      .playlistDb
      .values
      .map((e) => e.name.trim())
      .toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    const snackbar3 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist already exist',
          style: TextStyle(color: Colors.redAccent),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar3);
    Navigator.of(context).pop();
  } else {
    Provider.of<PlaylistDb>(context, listen: false).addPlaylist(music);
    const snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar4);
    Navigator.pop(context);
    nameController.clear();
  }
}
