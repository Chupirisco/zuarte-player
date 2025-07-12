import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/size_config.dart';

Widget componentCard({required double height, required Widget child}) {
  final width = overallWidth();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
    height: height,
    decoration: cardStyle(),
    child: child,
  );
}

BoxDecoration cardStyle() => BoxDecoration(
  color: LightColors.cardElements,
  borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
);
