import 'package:on_audio_query/on_audio_query.dart';

class MusicModel {
  final int id;
  final String title;
  final String author;
  final Uri uri;

  MusicModel({
    required this.id,
    required this.title,
    required this.author,

    required this.uri,
  });

  static Future<MusicModel> fromSongModel(SongModel song) async {
    return MusicModel(
      id: song.id,
      title: song.title,
      author: song.artist ?? 'Desconhecido',
      uri: Uri.file(song.data),
    );
  }
}
