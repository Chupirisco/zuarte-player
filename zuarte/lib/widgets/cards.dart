import 'package:flutter/material.dart';

import '../utils/size_config.dart';

Widget componentCard({
  required BuildContext ctx,
  required double height,
  required EdgeInsets padding,
  required Widget child,
}) {
  return Container(
    padding: padding,
    height: height,
    decoration: cardStyle(ctx),
    child: child,
  );
}

BoxDecoration cardStyle(BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: theme.primaryContainer,
    borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
  );
}
