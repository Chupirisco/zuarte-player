import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/size_config.dart';

Widget componentCard({
  required double height,
  required EdgeInsets padding,
  required Widget child,
}) {
  return Container(
    padding: padding,
    height: height,
    decoration: cardStyle(),
    child: child,
  );
}

BoxDecoration cardStyle() => BoxDecoration(
  color: LightColors.cardElements,
  borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
);
