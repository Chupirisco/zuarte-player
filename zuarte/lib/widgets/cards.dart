import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/widgets/load_music_image.dart';

import '../constants/icons.dart';
import '../model/music_model.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

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

Widget musicCard({
  required bool isSelected,
  required BuildContext context,
  required ColorScheme theme,
  required bool onOptions,
  required MusicModel music,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        margin: EdgeInsetsDirectional.only(bottom: 1.h),
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
        height: 6.h,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [theme.secondaryContainer, theme.onPrimaryContainer]
                : [theme.primaryContainer, theme.primaryContainer],
          ),

          borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
              child: LoadMusicImage(id: music.idImage, size: 5.h),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.2.h,
                    child: isSelected
                        ? textScrollConfig(music.title, theme.primary, 15)
                        : Text(
                            music.title,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              size: 15,
                              color: theme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),

                  SizedBox(
                    height: 2.h,
                    child: isSelected
                        ? textScrollConfig(music.author, theme.secondary, 12)
                        : Text(
                            music.author ?? "Desconhecido",
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              size: 12,
                              color: theme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            if (onOptions)
              SizedBox(
                width: constraints.maxWidth * 0.1,
                child: IconButton(
                  onPressed: () {},
                  icon: Iconify(
                    AppIcons.more,
                    color: theme.primary,
                    size: iconSize(20),
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}

Widget avatarComponent(
  double height,
  double width,
  String avatar,
  BuildContext context,
  double? iconSi,
) {
  final ColorScheme theme = Theme.of(context).colorScheme;
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: theme.surface,
      borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
    ),
    child: Center(
      child: Iconify(
        avatar,
        size: iconSize(iconSi ?? 20),
        color: iconColor(theme),
      ),
    ),
  );
}
