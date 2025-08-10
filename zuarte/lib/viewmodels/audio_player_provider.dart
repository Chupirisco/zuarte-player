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

  // getters
  int get idCurrentMusic =>
      _currentIndex == -1 ? _currentIndex : listSongs[_currentIndex].id;
  AudioPlayer get player => _player;
  bool get isPlaying => _player.playing;
  List<MusicModel> get listSongs => _listSongs;

  // init variable listSongs
  Future<void> initListSongs() async {
    List<SongModel> songs = await searchMusic();

    _listSongs = await Future.wait(
      songs.asMap().entries.map((entry) {
        final id = entry.key;
        final song = entry.value;
        return MusicModel.fromSongModel(song, id);
      }),
    );
    notifyListeners();
  }

  // updadte changes
  AudioPlayerProvider() {
    // Atualiza quando começa/para de tocar
    _player.playingStream.listen((_) => notifyListeners());

    // Atualiza a música atual quando o índice muda
    _player.currentIndexStream.listen((index) {
      if (index != null && index >= 0 && index < _listSongs.length) {
        _currentIndex = index;
        notifyListeners();
      }
    });
  }

  Future<void> setPlaylist(int startIndex) async {
    if (_listSongs.isEmpty) return;

    _currentIndex = startIndex;

    final sources = _listSongs.map((m) => AudioSource.uri(m.uri!)).toList();

    await _player.setAudioSources(sources, initialIndex: startIndex);
    await _player.play();
  }

  /// Alterna entre play e pause
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  /// Próxima música
  Future<void> next() async {
    await _player.seekToNext();
  }

  /// Música anterior
  Future<void> previous() async {
    await _player.seekToPrevious();
  }

  /// Liberar recursos
  @override
  Future<void> dispose() async {
    await _player.dispose();
    super.dispose();
  }
}
