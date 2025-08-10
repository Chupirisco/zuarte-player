import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/model/music_model.dart';

import '../services/search_music.dart';

class AudioPlayerProvider with ChangeNotifier {
  // controller
  final AudioPlayer _player = AudioPlayer();

  // variables
  List<MusicModel> _listSongs = [];
  int _currentIndex = -1;
  bool _isPlaying = false;

  // getters
  int get idCurrentMusic =>
      _currentIndex == -1 ? _currentIndex : listSongs[_currentIndex].id;
  AudioPlayer get player => _player;
  bool get isPlaying => _isPlaying;
  List<MusicModel> get listSongs => _listSongs;

  // init variable listSongs
  Future<void> initListSongs() async {
    List<SongModel> songs = await searchMusic();

    _listSongs = songs
        .asMap()
        .entries
        .map((entry) => MusicModel.fromSongModel(entry.value, entry.key))
        .toList();
    notifyListeners();
  }

  Future<void> setPlaylist(int startIndex) async {
    if (_listSongs.isEmpty) return;

    _currentIndex = startIndex;

    final sources = _listSongs.map((m) => AudioSource.uri(m.uri!)).toList();

    await _player.setAudioSources(sources, initialIndex: startIndex);
    await _player.play();

    _isPlaying = true;
    notifyListeners();
  }

  // Alterna entre play e pause
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    _isPlaying = _player.playing;
    notifyListeners();
  }

  // Próxima música
  Future<void> next() async {
    await _player.seekToNext();
    notifyListeners();
  }

  // Música anterior
  Future<void> previous() async {
    await _player.seekToPrevious();
    notifyListeners();
  }

  // Liberar recursos
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
