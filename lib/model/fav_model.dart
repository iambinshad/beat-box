



import 'package:hive_flutter/hive_flutter.dart';
part 'fav_model.g.dart';

@HiveType(typeId: 1)
class FavModel extends HiveObject {
  FavModel({required this.name, required this.songId});

  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songId;

  add(int id) async {
    songId.add(id);
    save();
  }

  deleteData(int id) {
    songId.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songId.contains(id);
  }
}
