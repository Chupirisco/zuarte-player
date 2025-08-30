import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/service_locator.dart';
import 'package:zuarte/widgets/custom_mini_player.dart';

import '../constants/icons.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

final songHandler = getIt<SongHandler>();

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
      child: Consumer(
        builder: (context, musicControlls, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _backButton(theme, widget.buttonHeight),
              _stopOrPlayButton(theme, widget.buttonHeight),
              _advanceButton(theme, widget.buttonHeight),
            ],
          );
        },
      ),
    );
  }
}

Widget _backButton(ColorScheme theme, double buttonHeight) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        await songHandler.skipToPrevious();
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

Widget _stopOrPlayButton(ColorScheme theme, double buttonHeight) {
  return StreamBuilder<PlaybackState>(
    stream: audioHandler.playbackState,
    builder: (context, snapshot) {
      final playing = snapshot.data?.playing ?? false;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (playing) {
              await songHandler.pause();
            } else {
              await songHandler.play();
            }
          },
          borderRadius: BorderRadius.circular(50),
          splashColor: theme.onPrimaryContainer,
          highlightColor: theme.onPrimaryContainer,
          child: Padding(
            padding: EdgeInsets.all(buttonHeight * 0.3),
            child: Iconify(
              playing ? AppIcons.pause : AppIcons.play,
              size: iconSize(buttonHeight),
              color: iconColor(theme),
            ),
          ),
        ),
      );
    },
  );
}

Widget _advanceButton(ColorScheme theme, double buttonHeight) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        await songHandler.skipToNext();
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
