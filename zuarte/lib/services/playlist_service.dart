import 'package:on_audio_query/on_audio_query.dart' hide PlaylistModel;

import '../models/playlist_model.dart';

class PlaylistService {
  final List<PlaylistModel> _playlists = [];

  List<PlaylistModel> get playlists => List.unmodifiable(_playlists);

  void createPlaylist(String name, Uri? artUri) {
    _playlists.add(
      PlaylistModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: name,
        numMusicas: 0,
        artUri: artUri,
        songs: [],
      ),
    );
  }

  void deletePlaylist(String id) {
    _playlists.removeWhere((p) => p.id == id);
  }

  void addSongToPlaylist(String playlistId, SongModel song) {
    final playlist = _playlists.firstWhere((p) => p.id == playlistId);
    if (!playlist.songs.any((s) => s.id == song.id)) {
      playlist.songs.add(song);
    }
  }

  void removeSongFromPlaylist(String playlistId, SongModel song) {
    final playlist = _playlists.firstWhere((p) => p.id == playlistId);
    playlist.songs.removeWhere((s) => s.id == song.id);
  }

  PlaylistModel? getPlaylist(String id) {
    return _playlists.firstWhere(
      (p) => p.id == id,
      orElse: () => PlaylistModel(id: '', nome: '', songs: [], numMusicas: 0),
    );
  }
}
