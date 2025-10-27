import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart' hide PlaylistModel;
import 'package:zuarte/models/playlist_model.dart';
import 'package:zuarte/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  final PlaylistService _service = PlaylistService();

  List<PlaylistModel> get playlists => _service.playlists;

  void createPlaylist(String name, Uri? artUri) {
    _service.createPlaylist(name, artUri);
    notifyListeners();
  }

  void deletePlaylist(String id) {
    _service.deletePlaylist(id);
    notifyListeners();
  }

  void addSong(String playlistId, SongModel song) {
    _service.addSongToPlaylist(playlistId, song);
    notifyListeners();
  }

  void removeSong(String playlistId, SongModel song) {
    _service.removeSongFromPlaylist(playlistId, song);
    notifyListeners();
  }

  PlaylistModel? getPlaylist(String id) => _service.getPlaylist(id);
}
