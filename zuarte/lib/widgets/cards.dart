import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../utils/size_config.dart';
import '../utils/style_configs.dart';

Widget componentCard({
  required BuildContext ctx,
  required double height,
  required EdgeInsets padding,
  required Widget child,
}) {
  return Container(
    padding: padding,
    height: height,
    decoration: cardStyle(ctx),
    child: child,
  );
}

BoxDecoration cardStyle(BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: theme.primaryContainer,
    borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
  );
}

Widget avatarComponent(
  double height,
  double width,
  String avatar,
  BuildContext context,
  double? iconSi,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: theme.surface,
      borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
    ),
    child: Center(
      child: Iconify(
        avatar,
        size: iconSize(iconSi ?? 20),
        color: iconColor(theme),
      ),
    ),
  );
}
