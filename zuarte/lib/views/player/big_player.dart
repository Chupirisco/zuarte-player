import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/views/player/progress_bar.dart';

import '../../constants/icons.dart';
import '../../utils/style_configs.dart';

Widget bigPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return Container(
    height: height,
    width: 100.w,
    padding: EdgeInsetsGeometry.symmetric(horizontal: defaultMargin()),
    child: Column(
      children: [
        Divider(
          color: theme.onPrimary,
          indent: 40.w,
          endIndent: 40.w,
          thickness: 5 + 0.1.h,
          radius: BorderRadius.circular(defaultBorderRadius(10)),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toxicity',
              style: textStyle(
                size: 18,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'System of Down',
              style: textStyle(
                size: 14,
                color: theme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/capaTeste.jpg',
                height: 30.h,
                width: 60.w,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),

        SizedBox(
          width: 60.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Iconify(
                  AppIcons.back,
                  size: iconSize(25),
                  color: iconColor(theme),
                ),
                splashColor: theme.onPrimaryContainer, // remove o splash
                highlightColor: theme.onPrimaryContainer, // remove o highlight
                hoverColor: theme.onPrimaryContainer, // remove hover
                padding: EdgeInsets.zero,
              ),
              IconButton(
                onPressed: () {},
                icon: Iconify(
                  AppIcons.play,
                  size: iconSize(26),
                  color: iconColor(theme),
                ),
                splashColor: theme.onPrimaryContainer,
                highlightColor: theme.onPrimaryContainer,
                hoverColor: theme.onPrimaryContainer,
                padding: EdgeInsets.zero,
              ),
              IconButton(
                onPressed: () {},
                icon: Iconify(
                  AppIcons.advance,
                  size: iconSize(25),
                  color: iconColor(theme),
                ),
                splashColor: theme.onPrimaryContainer,
                highlightColor: theme.onPrimaryContainer,
                hoverColor: theme.onPrimaryContainer,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '00:00',
              style: textStyle(
                size: 13,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            ProgressBar(),
          ],
        ),
        const Spacer(flex: 2),
      ],
    ),
  );
}
