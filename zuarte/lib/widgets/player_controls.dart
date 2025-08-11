import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';

import '../constants/icons.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key, required this.buttonHeight});
  final double buttonHeight;
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: Consumer<AudioPlayerProvider>(
        builder: (context, musicControlls, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backButton(theme, buttonHeight, musicControlls),
            _stopOrPlayButton(theme, buttonHeight, musicControlls),
            _advanceButton(theme, buttonHeight, musicControlls),
          ],
        ),
      ),
    );
  }
}

Widget _backButton(
  ColorScheme theme,
  double buttonHeight,
  AudioPlayerProvider musicControll,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => musicControll.previous(),
      borderRadius: BorderRadius.circular(50),
      splashColor: theme.onPrimaryContainer,
      highlightColor: theme.onPrimaryContainer,
      child: Padding(
        padding: EdgeInsets.all(buttonHeight * 0.3),
        child: Iconify(
          AppIcons.back,
          size: iconSize(buttonHeight),
          color: iconColor(theme),
        ),
      ),
    ),
  );
}

Widget _stopOrPlayButton(
  ColorScheme theme,
  double buttonHeight,
  AudioPlayerProvider musicControll,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: musicControll.togglePlayPause,
      borderRadius: BorderRadius.circular(50),
      splashColor: theme.onPrimaryContainer,
      highlightColor: theme.onPrimaryContainer,
      child: Padding(
        padding: EdgeInsets.all(buttonHeight * 0.3),
        child: Iconify(
          musicControll.isPlaying ? AppIcons.pause : AppIcons.play,
          size: iconSize(buttonHeight),
          color: iconColor(theme),
        ),
      ),
    ),
  );
}

Widget _advanceButton(
  ColorScheme theme,
  double buttonHeight,
  AudioPlayerProvider musicControll,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => musicControll.next(),
      borderRadius: BorderRadius.circular(50),
      splashColor: theme.onPrimaryContainer,
      highlightColor: theme.onPrimaryContainer,
      child: Padding(
        padding: EdgeInsets.all(buttonHeight * 0.3),
        child: Iconify(
          AppIcons.advance,
          size: iconSize(buttonHeight),
          color: iconColor(theme),
        ),
      ),
    ),
  );
}
