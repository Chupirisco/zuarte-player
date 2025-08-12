import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/model/music_model.dart';

import '../services/search_music.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  List<MusicModel> _listSongs = [];
  int _currentIndex = -1;
  bool _isPlaying = false;

  int get idCurrentMusic =>
      _currentIndex == -1 ? _currentIndex : listSongs[_currentIndex].id;
  AudioPlayer get player => _player;
  bool get isPlaying => _isPlaying;
  List<MusicModel> get listSongs => _listSongs;
  MusicModel get currentMusic => _player.currentIndex == null
      ? MusicModel(
          id: -1,
          idImage: -1,
          title: 'Nenhuma música selecionada',
          author: null,
          uri: null,
          duration: '',
        )
      : listSongs[_player.currentIndex!];

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
    await _player.seekToNext();
  }

  Future<void> previous() async {
    await _player.seekToPrevious();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
