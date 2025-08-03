import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/model/music_model.dart';
import 'package:zuarte/services/search_music.dart';

class ListSongsProvider with ChangeNotifier {
  final List<MusicModel> _listSongs = [];

  void initListSongs() async {
    List<SongModel> songs = await searchMusic();

    _listSongs.addAll(
      songs.map((song) => MusicModel.fromSongModel(song)).toList(),
    );
    notifyListeners();
  }
}
