import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zuarte/model/music_model.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  MusicModel? _selectedMusic;
  int get idSelectedMusic => _selectedMusic == null ? -1 : _selectedMusic!.id;
  AudioPlayer get player => _player;

  playSelectedMusic(MusicModel music) async {
    try {
      _selectedMusic = music;
      notifyListeners();
      await _player.setAudioSource(AudioSource.uri(music.uri!));
      await _player.play();
    } catch (e) {
      //future error message
    }
  }
}
