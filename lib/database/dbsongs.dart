import 'package:hive/hive.dart';
part 'dbsongs.g.dart';

@HiveType(typeId: 0)
class LocalSongs extends HiveObject {
  LocalSongs({
    required this.title,
    required this.artist,
    required this.uri,
    required this.duration,
    required this.id,
  });

  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  String? uri;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  int? id;
}

String boxname = "songs";

class MusicBox {
  static Box<List>? _box;

  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
