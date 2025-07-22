import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';

import '../../utils/style_configs.dart';

Widget playlistAvatarComponent(
  double height,
  double width,
  String avatar,
  BuildContext context,
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
      child: Iconify(avatar, size: iconSize(20), color: iconColor(theme)),
    ),
  );
}

ButtonStyle playlistButtonStyle(
  double height,
  double width,
  BuildContext context,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return ButtonStyle(
    alignment: Alignment.centerLeft,
    overlayColor: WidgetStatePropertyAll(theme.onPrimaryContainer),
    minimumSize: WidgetStatePropertyAll(Size(width, height)),
    padding: WidgetStatePropertyAll(EdgeInsets.all(12.sp)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(18)),
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(theme.primaryContainer),
  );
}
