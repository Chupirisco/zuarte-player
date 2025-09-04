import 'package:hive/hive.dart';

import '../../model/song.dart';

class MusicCacheService {
  final Box<Song> _box = Hive.box<Song>('songsBox');

  Future<void> saveSongs(List<Song> songs) async {
    await _box.clear();
    await _box.addAll(songs);
  }

  List<Song> loadSongs() {
    return _box.values.toList();
  }
}
