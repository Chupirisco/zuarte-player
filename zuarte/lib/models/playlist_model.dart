import 'package:on_audio_query/on_audio_query.dart';

class PlaylistModel {
  final String id;
  final String nome;
  final int numMusicas;
  final List<SongModel> songs;

  PlaylistModel({
    required this.id,
    required this.nome,
    required this.numMusicas,
    required this.songs,
  });

  PlaylistModel copyWith({
    String? id,
    String? nome,
    int? numMusicas,
    List<SongModel>? songs,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numMusicas: numMusicas ?? this.numMusicas,
      songs: songs ?? this.songs,
    );
  }
}
