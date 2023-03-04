import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/fav_model.dart';

class PlaylistDb extends ChangeNotifier {
   
  // static ValueNotifier<List<FavModel>> playlistNotifiier =
  //     ValueNotifier([]);
  List<FavModel> playListNotifier = [];
  final playlistDb = Hive.box<FavModel>('playlistDb');

  Future<void> addPlaylist(FavModel value) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.add(value);
    playListNotifier.add(value);
  }

  Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    playListNotifier.clear();
    playListNotifier.addAll(playlistDb.values);
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  Future<void> editList(int index, FavModel value) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
    notifyListeners();
  }
}
