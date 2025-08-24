import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/model/music_model.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/request_songs_permissions.dart';
import 'package:zuarte/services/song_model_to_media_item.dart';

import '../services/search_music.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  List<MusicModel> _listSongs = [];
  int _currentIndex = -1;
  bool _isPlaying = false;
  final MusicModel _noSongSelected = MusicModel(
    id: -1,
    idImage: -1,
    title: 'Nenhuma música selecionada',
    author: null,
    uri: null,
    duration: '',
  );

  int get idCurrentMusic =>
      _currentIndex == -1 ? _currentIndex : listSongs[_currentIndex].id;
  AudioPlayer get player => _player;
  bool get isPlaying => _isPlaying;
  List<MusicModel> get listSongs => _listSongs;
  MusicModel get currentMusic => _player.currentIndex == null
      ? _noSongSelected
      : listSongs[_player.currentIndex!];

  MusicModel get nextMusic => _player.currentIndex == null
      ? _noSongSelected
      : listSongs[idCurrentMusic == listSongs.length - 1
            ? 0
            : idCurrentMusic + 1];

  AudioPlayerProvider() {
    _player.playingStream.listen((playing) {
      if (_isPlaying != playing) {
        _isPlaying = playing;
        notifyListeners();
      }
    });

    _player.currentIndexStream.listen((index) {
      if (index != null && index != _currentIndex) {
        _currentIndex = index;
        notifyListeners();
      }
    });
    _player.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        if (_player.currentIndex == listSongs.length - 1) {
          await _player.seek(Duration.zero, index: 0);
          await _player.play();
        } else {
          await _player.seekToNext();
          await _player.play();
        }
      }
    });
  }

  Future<void> initListSongs() async {
    List<SongModel> songs = await searchMusic();

    _listSongs = songs
        .where((song) => song.uri != null)
        .toList()
        .asMap()
        .entries
        .map((entry) => MusicModel.fromSongModel(entry.value, entry.key))
        .toList();

    notifyListeners();
  }

  Future<void> setPlaylist(int startIndex) async {
    if (_listSongs.isEmpty) return;

    _currentIndex = startIndex;

    final sources = _listSongs
        .where((m) => m.uri != null)
        .map((m) => AudioSource.uri(m.uri!))
        .toList();

    await _player.setAudioSources(sources, initialIndex: startIndex);
    await _player.play();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> next() async {
    if (_player.currentIndex == listSongs.length - 1) {
      await _player.seek(Duration.zero, index: 0);
    } else {
      await _player.seekToNext();
    }
  }

  Future<void> previous() async {
    if (_player.currentIndex == 0) {
      final lastIndex = _listSongs.length - 1;
      await _player.seek(Duration.zero, index: lastIndex);
    } else {
      await _player.seekToPrevious();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

Future<List<MediaItem>> getSongs() async {
  try {
    await requestSonsPermission();
    final List<MediaItem> songs = [];

    final OnAudioQuery onAudioQuery = OnAudioQuery();

    final List<SongModel> songsModels = await onAudioQuery.querySongs();

    for (final SongModel songModel in songsModels) {
      final MediaItem song = await songModelToMediaItem(songModel);
      songs.add(song);
    }

    return songs;
  } catch (e) {
    return [];
  }
}

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
}
