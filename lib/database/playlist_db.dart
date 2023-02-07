
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/fav_model.dart';

class PlaylistDb {
  static ValueNotifier<List<FavModel>> playlistNotifiier =
      ValueNotifier([]);
  static final playlistDb = Hive.box<FavModel>('playlistDb');

  static Future<void> addPlaylist(FavModel value) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.add(value);
    playlistNotifiier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    playlistNotifiier.value.clear();
    playlistNotifiier.value.addAll(playlistDb.values);
    playlistNotifiier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, FavModel value) async {
    final playlistDb = Hive.box<FavModel>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }
}
