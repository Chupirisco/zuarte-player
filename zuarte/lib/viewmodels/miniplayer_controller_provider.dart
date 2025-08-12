import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniplayerControllerProvider with ChangeNotifier {
  final MiniplayerController _miniplayerController = MiniplayerController();

  MiniplayerController get controller => _miniplayerController;

  void expandedMiniPlayer() {
    _miniplayerController.animateToHeight(state: PanelState.MAX);
    notifyListeners();
  }
}
