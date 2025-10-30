import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:hive/hive.dart';
import '../models/playlist_model.dart';
import '../models/hive_media_item_model.dart';

class PlaylistService {
  static const String _boxName = 'playlists';
  Box<PlaylistModel>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<PlaylistModel>(_boxName);
  }

  List<PlaylistModel> get playlists => _box?.values.toList() ?? [];

  Future<void> createPlaylist(
    String name,
    File? artUri,
    List<MediaItem> songs,
  ) async {
    final playlist = PlaylistModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: name,
      artUriPath: artUri?.path,
      songs: songs.map((s) => HiveMediaItem.fromMediaItem(s)).toList(),
    );
    await _box?.put(playlist.id, playlist);
  }

  Future<void> deletePlaylist(String id) async {
    await _box?.delete(id);
  }

  Future<void> addSongToPlaylist(String playlistId, MediaItem song) async {
    final playlist = _box?.get(playlistId);
    if (playlist != null && !playlist.songs.any((s) => s.id == song.id)) {
      playlist.songs.add(HiveMediaItem.fromMediaItem(song));
      await playlist.save();
    }
  }

  Future<void> removeSongFromPlaylist(String playlistId, MediaItem song) async {
    final playlist = _box?.get(playlistId);
    if (playlist != null) {
      playlist.songs.removeWhere((s) => s.id == song.id);
      await playlist.save();
    }
  }

  PlaylistModel? getPlaylist(String id) {
    return _box?.get(id);
  }
}
