import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/widgets/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/player_controls.dart';

import '../../widgets/custom_divider.dart';

Widget miniPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return Consumer<AudioPlayerProvider>(
    builder: (context, provider, child) => Container(
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
                    Text(
                      provider.currentMusic.title,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle(
                        size: 16,
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ?provider.currentMusic.author == null
                        ? null
                        : Text(
                            provider.currentMusic.author!,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              size: 14,
                              color: theme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              //control icons
              PlayerControls(buttonHeight: 20),
            ],
          ),

          ProgressBar(audioPlayer: provider.player),

          const Spacer(),
        ],
      ),
    ),
  );
}
