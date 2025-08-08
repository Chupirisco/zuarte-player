import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:zuarte/model/music_model.dart';

class MiniplayerControllerProvider with ChangeNotifier {
  MusicModel? _selectedMusic;
  final MiniplayerController _miniplayerController = MiniplayerController();

  MusicModel get selectedMusic =>
      _selectedMusic ??
      MusicModel(
        id: -1,
        title: 'Nenhuma música selecionada',
        author: null,
        uri: null,
        duration: '00:00',
      );
  MiniplayerController get controller => _miniplayerController;

  void expandedMiniPlayer(MusicModel music) {
    _miniplayerController.animateToHeight(state: PanelState.MAX);
    _selectedMusic = music;
    notifyListeners();
  }
}
