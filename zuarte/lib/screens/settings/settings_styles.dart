import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../utils/size_config.dart';

BoxDecoration cardsSettingsScreen() => BoxDecoration(
  color: LightColors.cardElements,
  borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
);

Widget radioDecoration(dynamic themeSelected, dynamic valueTheme) {
  final sizeRadio = 15.sp;
  return Container(
    height: sizeRadio,
    width: sizeRadio,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: LightColors.borders, width: 1),
      color: themeSelected == valueTheme ? Colors.green : Colors.white,
    ),
  );
}

ButtonStyle buttonStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(LightColors.cardElements),
    shadowColor: WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(15)),
        side: BorderSide(color: LightColors.primaryAction),
      ),
    ),
  );
}
