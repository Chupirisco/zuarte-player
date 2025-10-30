import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';

ElevatedButton buttonComponent({
  required Color surfaceColor,
  Color? borderColor,
  required Widget child,
  required VoidCallback onClick,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(30.w, 5.h)),
      maximumSize: WidgetStatePropertyAll(Size(30.w, 5.h)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(15)),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(surfaceColor),
    ),
    onPressed: onClick,
    child: child,
  );
}

IconButton iconButtonComponent({
  required VoidCallback onClick,
  required ColorScheme theme,
  required String icon,
  required double size,
  Color? background,
  Color? white,
}) {
  return IconButton(
    splashColor: theme.onPrimaryContainer,
    highlightColor: theme.onPrimaryContainer,
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(background ?? null),
      minimumSize: WidgetStatePropertyAll(Size(3.h, 3.h)),
      maximumSize: WidgetStatePropertyAll(Size(5.h, 5.h)),
    ),
    onPressed: onClick,
    icon: Iconify(icon, size: size, color: white ?? theme.primary),
  );
}
