import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';

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
