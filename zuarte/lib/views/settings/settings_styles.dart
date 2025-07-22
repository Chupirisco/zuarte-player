import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/size_config.dart';

Widget radioDecoration(
  dynamic themeSelected,
  dynamic valueTheme,
  BuildContext context,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  final sizeRadio = 15.sp;
  return Container(
    height: sizeRadio,
    width: sizeRadio,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: theme.onPrimary, width: 1),
      color: themeSelected == valueTheme ? Colors.green : Colors.white,
    ),
  );
}

ButtonStyle settingsButtonStyle(BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(theme.primaryContainer),
    shadowColor: WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(15)),
        side: BorderSide(color: theme.onPrimaryContainer),
      ),
    ),
  );
}
