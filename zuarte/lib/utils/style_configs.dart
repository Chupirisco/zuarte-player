import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

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

TextScroll textScrollConfig(String? text, Color color, double textSize) {
  final Duration durarion = Duration(seconds: 2);

  return TextScroll(
    text ?? '',
    style: textStyle(size: textSize, color: color, fontWeight: FontWeight.bold),
    velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
    mode: TextScrollMode.bouncing,
    delayBefore: durarion,
    pauseBetween: durarion,
    pauseOnBounce: durarion,
    selectable: false,
  );
}
