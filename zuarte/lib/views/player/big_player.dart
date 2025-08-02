import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/views/player/big_player_components.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/widgets/player_controls.dart';

Widget bigPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 5 + 0.1.h,
          width: 20.w,
          decoration: BoxDecoration(
            color: theme.onPrimary,
            borderRadius: BorderRadius.circular(defaultBorderRadius(10)),
          ),
        ),
        SizedBox(height: 8.h),
        musicInformation(context, theme),
        SizedBox(height: 3.h),
        SizedBox(width: 34.h, child: PlayerControls(buttonHeight: 25)),
        SizedBox(height: 2.h),
        ProgressBar(),
        SizedBox(height: 8.h),
        nextMusic(context, theme),
      ],
    ),
  );
}
