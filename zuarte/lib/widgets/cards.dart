import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/style_configs.dart';

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

Widget musicCard(BuildContext context, ColorScheme theme, bool onOptions) {
  return Container(
    margin: EdgeInsetsDirectional.only(bottom: 1.h),
    padding: EdgeInsets.only(left: 20),
    height: 6.h,
    width: 100.w,
    decoration: BoxDecoration(
      color: theme.primaryContainer,
      borderRadius: BorderRadius.circular(defaultBorderRadius(25)),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(15)),
          child: Image.asset(
            'assets/images/capaTeste.jpg',
            fit: BoxFit.cover,
            height: 5.h,
            width: 5.h,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'titulo',
              style: textStyle(
                size: 15,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Autor',
              style: textStyle(
                size: 12,
                color: theme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onOptions
            ? Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Iconify(
                      AppIcons.more,
                      color: theme.primary,
                      size: iconSize(20),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}
