import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/request_songs_permissions.dart';
import 'package:zuarte/services/song_model_to_media_item.dart';

import '../services/search_music.dart';

class SongProvider extends ChangeNotifier {
  List<MediaItem> _songs = [];

  List<MediaItem> get songs => _songs;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> loadSongs(SongHandler songHandler) async {
    _songs = await getSongs();

    await songHandler.initSongs(_songs);
    _isLoading = false;
    notifyListeners();
  }

  Future<List<MediaItem>> getSongs() async {
    try {
      await requestSonsPermission();
      final List<MediaItem> songs = [];

      final songsModels = await searchMusic();

      for (final SongModel songModel in songsModels) {
        final MediaItem song = await songModelToMediaItem(songModel);
        songs.add(song);
      }

      return songs;
    } catch (e) {
      return [];
    }
  }
}
