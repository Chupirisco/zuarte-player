import 'package:flutter/material.dart';
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
