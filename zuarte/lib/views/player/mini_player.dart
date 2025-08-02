import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/player_controls.dart';

Widget miniPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Nenhuma música selecionada',
              style: textStyle(
                size: 15,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            //control icons
            PlayerControls(buttonHeight: 22),
          ],
        ),
        SizedBox(height: height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProgressBar(),
            Text(
              '00:00',
              style: textStyle(
                size: 14,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
