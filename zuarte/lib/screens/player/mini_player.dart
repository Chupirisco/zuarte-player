import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/screens/player/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/text_style_config.dart';

Widget miniPlayer(double height) {
  return Container(
    decoration: BoxDecoration(
      color: LightColors.cardElements,
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
                color: LightColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Iconify(AppIcons.back, size: iconSize(23)),
              splashColor: LightColors.primaryAction, // remove o splash
              highlightColor: LightColors.primaryAction, // remove o highlight
              hoverColor: LightColors.primaryAction, // remove hover
              padding: EdgeInsets.symmetric(vertical: 0),
            ),
            IconButton(
              onPressed: () {},
              icon: Iconify(AppIcons.play, size: iconSize(24)),
              splashColor: LightColors.primaryAction,
              highlightColor: LightColors.primaryAction,
              hoverColor: LightColors.primaryAction,
              padding: EdgeInsets.all(0),
            ),
            IconButton(
              onPressed: () {},
              icon: Iconify(AppIcons.advance, size: iconSize(23)),
              splashColor: LightColors.primaryAction,
              highlightColor: LightColors.primaryAction,
              hoverColor: LightColors.primaryAction,
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
        SizedBox(height: height * 0.1),
        ProgressBar(),
      ],
    ),
  );
}
