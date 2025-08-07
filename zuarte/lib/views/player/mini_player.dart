import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/player_controls.dart';

import '../../viewmodels/miniplayer_controller_provider.dart';
import '../../widgets/custom_divider.dart';

Widget miniPlayer(
  double height,
  MiniplayerControllerProvider provider,
  BuildContext context,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  final Duration durarion = Duration(seconds: 2);
  return Container(
    decoration: BoxDecoration(
      color: theme.primaryContainer,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(defaultBorderRadius(20)),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Align(alignment: Alignment.topCenter, child: customDivider(theme)),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextScroll(
                    provider.selectedMusic.title,
                    style: textStyle(
                      size: 16,
                      color: theme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
                    mode: TextScrollMode.bouncing,
                    delayBefore: durarion,
                    pauseBetween: durarion,
                    pauseOnBounce: durarion,
                    selectable: false,
                  ),
                  ?provider.selectedMusic.author == null
                      ? null
                      : TextScroll(
                          provider.selectedMusic.author!,
                          style: textStyle(
                            size: 14,
                            color: theme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                          velocity: const Velocity(
                            pixelsPerSecond: Offset(10, 0),
                          ),
                          mode: TextScrollMode.bouncing,
                          delayBefore: durarion,
                          pauseBetween: durarion,
                          pauseOnBounce: durarion,
                          selectable: false,
                        ),
                ],
              ),
            ),
            //control icons
            PlayerControls(buttonHeight: 20),
          ],
        ),

        Consumer<AudioPlayerProvider>(
          builder: (context, value, child) =>
              ProgressBar(audioPlayer: value.player),
        ),
        const Spacer(),
      ],
    ),
  );
}
