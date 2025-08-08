import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/model/music_model.dart';
import 'package:zuarte/widgets/load_music_image.dart';
import '../../utils/style_configs.dart';
import '../../widgets/cards.dart';

final Duration durarion = Duration(seconds: 2);
Widget musicInformation(
  BuildContext context,
  ColorScheme theme,
  MusicModel music,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34.h,
            child: textScrollConfig(music.title, theme.primary, 17),
          ),
          SizedBox(
            width: 34.w,
            child: textScrollConfig(music.author, theme.secondary, 14),
          ),
        ],
      ),
      SizedBox(height: 1.h),

      LoadMusicImage(id: music.id, size: 35.h),
    ],
  );
}

Widget nextMusic(BuildContext context, MusicModel music, ColorScheme theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Text(
          'Próxima',
          style: textStyle(
            size: 16,
            color: theme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 5),

      musicCard(
        isSelected: false,
        context: context,
        theme: theme,
        onOptions: false,
        music: music,
      ),
    ],
  );
}
