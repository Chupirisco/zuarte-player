import 'dart:io';

import 'package:audio_service/audio_service.dart';

import '../models/playlist_model.dart';

class PlaylistService {
  final List<PlaylistModel> _playlists = [];

  List<PlaylistModel> get playlists => List.unmodifiable(_playlists);

  void createPlaylist(String name, File? artUri, List<MediaItem> songs) {
    _playlists.add(
      PlaylistModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: name,
        artUri: artUri,
        songs: songs,
      ),
    );
  }

  void deletePlaylist(String id) {
    _playlists.removeWhere((p) => p.id == id);
  }

  void addSongToPlaylist(String playlistId, MediaItem song) {
    final playlist = _playlists.firstWhere((p) => p.id == playlistId);
    if (!playlist.songs.any((s) => s.id == song.id)) {
      playlist.songs.add(song);
    }
  }

  void removeSongFromPlaylist(String playlistId, MediaItem song) {
    final playlist = _playlists.firstWhere((p) => p.id == playlistId);
    playlist.songs.removeWhere((s) => s.id == song.id);
  }

  PlaylistModel? getPlaylist(String id) {
    return _playlists.firstWhere(
      (p) => p.id == id,
      orElse: () => PlaylistModel(id: '', nome: '', songs: []),
    );
  }
}
