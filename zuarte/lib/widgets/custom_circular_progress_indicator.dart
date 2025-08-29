import 'package:flutter/material.dart';

Widget customCircularProgressIndicator(ColorScheme theme) {
  return Center(
    child: CircularProgressIndicator(
      color: theme.secondaryContainer,
      strokeCap: StrokeCap.round,
    ),
  );
}
