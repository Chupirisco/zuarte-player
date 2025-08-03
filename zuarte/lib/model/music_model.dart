import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class MusicModel {
  final int id;
  final String title;
  final String author;
  final Uint8List? cover;
  final String? uri;

  MusicModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.uri,
  });

  static Future<MusicModel> fromSongModel(SongModel song) async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    Uint8List? coverData = await audioQuery.queryArtwork(
      song.id,
      ArtworkType.AUDIO,
    );
    return MusicModel(
      id: song.id,
      title: song.title,
      author: song.artist ?? 'Desconhecido',
      cover: coverData,
      uri: song.uri,
    );
  }
}
