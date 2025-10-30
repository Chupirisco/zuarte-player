import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zuarte/utils/size_config.dart';

import '../constants/icons.dart';
import '../services/uri_to_file.dart';

Widget buildImage(ColorScheme theme, Uri? art, double height, double width) {
  return FutureBuilder<File?>(
    future: uriToFile(art),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Iconify(AppIcons.alert);
      }
      return Container(
        margin: EdgeInsets.only(left: 5),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius(14)),
          color: theme.surface,
        ),
        child: snapshot.data == null
            ? Iconify(AppIcons.person)
            : ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(
                  defaultBorderRadius(14),
                ),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: FileImage(snapshot.data!),
                  fadeInDuration: const Duration(milliseconds: 700),
                  fit: BoxFit.cover,
                ),
              ),
      );
    },
  );
}
