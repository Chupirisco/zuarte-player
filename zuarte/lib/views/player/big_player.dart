import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/views/player/player_components.dart';
import 'package:zuarte/widgets/progress_bar.dart';
import 'package:zuarte/widgets/player_controls.dart';

import '../../viewmodels/audio_player_provider.dart';
import '../../viewmodels/miniplayer_controller_provider.dart';
import '../../widgets/custom_divider.dart';

Widget bigPlayer(
  double height,
  MiniplayerControllerProvider provider,
  BuildContext context,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customDivider(theme),
        SizedBox(height: 30.sp),
        musicInformation(context, theme, provider.selectedMusic),
        SizedBox(height: 3.h),
        SizedBox(width: 36.h, child: PlayerControls(buttonHeight: 25)),
        SizedBox(height: 2.h),
        Consumer<AudioPlayerProvider>(
          builder: (context, value, child) =>
              ProgressBar(audioPlayer: value.player),
        ),
        SizedBox(height: 30.sp),
        nextMusic(context, provider.selectedMusic, theme),
      ],
    ),
  );
}
