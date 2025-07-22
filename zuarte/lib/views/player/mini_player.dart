import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';

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
            IconButton(
              onPressed: () {},
              icon: Iconify(
                AppIcons.back,
                size: iconSize(22),
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
                size: iconSize(23),
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
                size: iconSize(22),
                color: iconColor(theme),
              ),
              splashColor: theme.onPrimaryContainer,
              highlightColor: theme.onPrimaryContainer,
              hoverColor: theme.onPrimaryContainer,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        SizedBox(height: height * 0.1),
        ProgressBar(),
      ],
    ),
  );
}
