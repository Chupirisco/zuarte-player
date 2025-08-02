import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/views/player/big_player_components.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/widgets/player_controls.dart';

import '../../widgets/custom_divider.dart';

Widget bigPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDivider(theme),
        SizedBox(height: 30.sp),
        musicInformation(context, theme),
        SizedBox(height: 3.h),
        SizedBox(width: 34.h, child: PlayerControls(buttonHeight: 25)),
        SizedBox(height: 2.h),
        ProgressBar(),
        SizedBox(height: 30.sp),
        nextMusic(context, theme),
      ],
    ),
  );
}
