import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/size_config.dart';

Widget customDivider(ColorScheme theme) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    height: 5 + 0.1.h,
    width: 20.w,
    decoration: BoxDecoration(
      color: theme.onPrimary,
      borderRadius: BorderRadius.circular(defaultBorderRadius(10)),
    ),
  );
}
