import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/utils/size_config.dart';

Widget playlistAvatarComponent(double height, double width, String avatar) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: LightColors.background,
      borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
    ),
    child: Center(child: Iconify(avatar, size: iconSize(20))),
  );
}

ButtonStyle playlistButtonStyle(double height, double width) {
  return ButtonStyle(
    overlayColor: WidgetStatePropertyAll(LightColors.primaryAction),
    minimumSize: WidgetStatePropertyAll(Size(width, height)),
    padding: WidgetStatePropertyAll(EdgeInsets.all(12.sp)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(18)),
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(LightColors.cardElements),
  );
}
