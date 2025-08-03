import 'package:on_audio_query/on_audio_query.dart';

class MusicModel {
  final int id;
  final String title;
  final String author;
  final dynamic cover;

  MusicModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
  });

  factory MusicModel.fromSongModel(SongModel song) {
    return MusicModel(
      id: song.id,
      title: song.title,
      author: song.artist ?? "Desconhecido",
      cover: null,

      //loadCover(song.id),
    );
  }

  static loadCover(int id) async {}
}
