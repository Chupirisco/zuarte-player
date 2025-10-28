import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:zuarte/models/playlist_model.dart';
import 'package:zuarte/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  final PlaylistService _service = PlaylistService();

  List<PlaylistModel> get playlists => _service.playlists;
  List<MediaItem> _addSongPlaylist = [];

  void createPlaylist(String name, File? artUri) {
    _service.createPlaylist(
      name,
      artUri,
      List<MediaItem>.from(_addSongPlaylist),
    );
    _addSongPlaylist.clear();
    notifyListeners();
  }

  void deletePlaylist(String id) {
    _service.deletePlaylist(id);
    notifyListeners();
  }

  void addSong(String playlistId, MediaItem song) {
    _service.addSongToPlaylist(playlistId, song);
    notifyListeners();
  }

  void removeSong(String playlistId, MediaItem song) {
    _service.removeSongFromPlaylist(playlistId, song);
    notifyListeners();
  }

  void manageSongList(MediaItem song, bool isSelected) {
    isSelected
        ? _addSongPlaylist.add(song)
        : _addSongPlaylist.removeWhere((s) => s.id == song.id);
    notifyListeners();
  }

  PlaylistModel? getPlaylist(String id) => _service.getPlaylist(id);
}
