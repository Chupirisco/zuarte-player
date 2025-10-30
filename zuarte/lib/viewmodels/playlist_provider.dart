import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/hive_media_item_model.dart';
import '../models/playlist_model.dart';
import 'package:audio_service/audio_service.dart';

class PlaylistProvider extends ChangeNotifier {
  late Box<PlaylistModel> _box;

  List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => List.unmodifiable(_playlists);

  List<MediaItem> _addSongPlaylist = [];
  List<MediaItem> get addSongPlaylist => _addSongPlaylist;

  Future<void> init() async {
    _box = await Hive.openBox<PlaylistModel>('playlists');
    _playlists = _box.values.toList();
    notifyListeners();
  }

  void createPlaylist(String name, Uri? artUri) {
    final playlist = PlaylistModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: name,
      songs: _addSongPlaylist
          .map((e) => HiveMediaItem.fromMediaItem(e))
          .toList(),
      artUriPath: artUri?.path.toString(),
    );

    _box.put(playlist.id, playlist);
    _playlists.add(playlist);

    clearSongList();
    notifyListeners();
  }

  void editPlaylist(String id, String nome, Uri? artUri) async {
    final playlist = _box.get(id);
    if (playlist == null) return;
    playlist.nome = nome;
    playlist.artUriPath = artUri?.toString();

    await playlist.save();

    notifyListeners();
  }

  void deletePlaylist(String id) {
    _box.delete(id);
    _playlists.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void addSong(String playlistId) {
    final playlist = _box.get(playlistId);
    if (playlist == null) return;

    for (var song in _addSongPlaylist) {
      if (!playlist.songs.any((s) => s.id == song.id)) {
        playlist.songs.add(HiveMediaItem.fromMediaItem(song));
      }
    }

    playlist.save();
    clearSongList();
    notifyListeners();
  }

  void removeSong(String playlistId, MediaItem song) {
    final playlist = _box.get(playlistId);
    if (playlist == null) return;

    playlist.songs.removeWhere((s) => s.id == song.id);
    playlist.save();
    notifyListeners();
  }

  void manageSongList(MediaItem song, bool isSelected) {
    isSelected
        ? _addSongPlaylist.add(song)
        : _addSongPlaylist.removeWhere((s) => s.id == song.id);
    notifyListeners();
  }

  void clearSongList() {
    _addSongPlaylist.clear();
  }

  PlaylistModel? getPlaylist(String id) => _box.get(id);
}
