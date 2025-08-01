import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextStyle textStyle({
  required double size,
  required Color color,
  FontWeight? fontWeight,
}) {
  return TextStyle(fontSize: size.sp, color: color, fontWeight: fontWeight);
}

AlwaysScrollableScrollPhysics scrollEffect() {
  return AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());
}

Color iconColor(ColorScheme theme) {
  return theme.primary;
}
