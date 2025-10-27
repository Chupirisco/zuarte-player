import 'package:on_audio_query/on_audio_query.dart';

class PlaylistModel {
  final String id;
  final String nome;
  final int numMusicas;
  final List<SongModel> songs;
  final Uri? artUri;

  PlaylistModel({
    required this.id,
    required this.nome,
    required this.numMusicas,
    required this.songs,
    this.artUri,
  });
}
