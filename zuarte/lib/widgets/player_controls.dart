// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/viewmodels/miniplayer_controller_provider.dart';

import '../constants/icons.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({super.key, required this.buttonHeight});
  final double buttonHeight;

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: Consumer<AudioPlayerProvider>(
        builder: (context, musicControlls, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _backButton(theme, widget.buttonHeight, musicControlls, context),
              _stopOrPlayButton(theme, widget.buttonHeight, musicControlls),
              _advanceButton(
                theme,
                widget.buttonHeight,
                musicControlls,
                context,
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _backButton(
  ColorScheme theme,
  double buttonHeight,
  AudioPlayerProvider musicControll,
  BuildContext context,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        if (musicControll.currentMusic != null) {
          await musicControll.previous();
          context.read<MiniplayerControllerProvider>().updateMiniPlayer(
            musicControll.currentMusic!,
          );
        }
      },
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
      onTap: () async {
        if (musicControll.currentMusic != null) {
          musicControll.togglePlayPause();
        }
      },
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
  BuildContext context,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        if (musicControll.currentMusic != null) {
          await musicControll.next();
          context.read<MiniplayerControllerProvider>().updateMiniPlayer(
            musicControll.currentMusic!,
          );
        }
      },
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
