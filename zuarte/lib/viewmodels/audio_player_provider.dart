import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zuarte/model/music_model.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  List<MusicModel> _playlistPlaying = [];
  int _currentIndex = -1;

  MusicModel? _selectedMusic;
  int get idSelectedMusic => _selectedMusic == null ? -1 : _selectedMusic!.id;
  AudioPlayer get player => _player;

  bool get isPlaying => _player.playing;

  void setPlaylistPlaying(List<MusicModel> musics) {
    _playlistPlaying = musics;
  }

  Future<void> playSelectedMusic(MusicModel music) async {
    try {
      _selectedMusic = music;
      _currentIndex = _playlistPlaying.indexWhere(
        (song) => song.id == music.id,
      );
      notifyListeners();

      await _player.setAudioSource(AudioSource.uri(music.uri!));
      await _player.play();
    } catch (e) {
      //future error message
    }
  }

  Future<void> pauseOrStart() async {
    isPlaying ? await _player.stop() : await _player.play();
    notifyListeners();
  }

  Future<void> next() async {
    if (_playlistPlaying.isEmpty || _currentIndex == -1) return;
    int nextSong = (_currentIndex + 1) % _playlistPlaying.length;
    await playSelectedMusic(_playlistPlaying[nextSong]);
  }

  Future<void> previous() async {
    if (_playlistPlaying.isEmpty || _currentIndex == -1) return;
    int prevSong =
        (_currentIndex - 1 + _playlistPlaying.length) % _playlistPlaying.length;
    await playSelectedMusic(_playlistPlaying[prevSong]);
  }
}
