import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/size_config.dart';

Widget playlistAvatarComponent(double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: LightColors.background,
      borderRadius: BorderRadius.circular(defaultBorderRadius(17)),
    ),
    child: Center(child: Iconify(AppIcons.add)),
  );
}
