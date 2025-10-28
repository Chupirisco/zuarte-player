import 'dart:io';

import 'package:audio_service/audio_service.dart';

class PlaylistModel {
  final String id;
  final String nome;
  final List<MediaItem> songs;
  final File? artUri;

  PlaylistModel({
    required this.id,
    required this.nome,
    required this.songs,
    this.artUri,
  });
  int get numMusicas => songs.length;
}
