import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/widgets/cards.dart';

import '../constants/icons.dart';
import '../utils/size_config.dart';

class LoadMusicImage extends StatelessWidget {
  const LoadMusicImage({super.key, required this.id, required this.size});
  final int id;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
      child: QueryArtworkWidget(
        id: id,
        type: ArtworkType.AUDIO,
        artworkHeight: size,
        artworkWidth: size,
        artworkClipBehavior: Clip.none,
        nullArtworkWidget: avatarComponent(
          size,
          size,
          AppIcons.person,
          context,
          20.sp,
        ),
      ),
    );
  }
}
