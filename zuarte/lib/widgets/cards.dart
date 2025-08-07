import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:zuarte/constants/colors.dart';

import '../constants/icons.dart';
import '../model/music_model.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

final Duration _durarion = Duration(seconds: 2);

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
              child: QueryArtworkWidget(
                id: music.id,
                type: ArtworkType.AUDIO,
                artworkHeight: 5.h,
                artworkWidth: 5.h,
                artworkClipBehavior: Clip.none,
                nullArtworkWidget: avatarComponent(
                  5.h,
                  5.h,
                  AppIcons.person,
                  context,
                ),
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.2.h,
                    child: TextScroll(
                      music.title,
                      style: textStyle(
                        size: 15,
                        color: isSelected
                            ? DarkColors.primaryText
                            : theme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
                      mode: TextScrollMode.bouncing,
                      delayBefore: _durarion,
                      pauseBetween: _durarion,
                      pauseOnBounce: _durarion,
                      selectable: false,
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                    child: TextScroll(
                      music.author!,
                      style: textStyle(
                        size: 12,
                        color: theme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
                      mode: TextScrollMode.bouncing,
                      delayBefore: _durarion,
                      pauseBetween: _durarion,
                      pauseOnBounce: _durarion,
                      selectable: false,
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
      child: Iconify(avatar, size: iconSize(20), color: iconColor(theme)),
    ),
  );
}
