import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:zuarte/utils/formatted_text.dart';
import 'package:zuarte/utils/size_config.dart';

import '../utils/build_image.dart';

class SongItem extends StatelessWidget {
  final String? searchedWord;
  final bool isPlaying;
  final Uri? art;
  final String? title;
  final String? artist;
  final String id;
  final VoidCallback onSongTap;

  const SongItem({
    super.key,
    this.searchedWord,
    required this.isPlaying,
    this.art,
    this.title,
    this.artist,
    required this.id,
    required this.onSongTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onSongTap(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        height: 6.h,
        width: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isPlaying
                ? [theme.secondaryContainer, theme.onPrimaryContainer]
                : [theme.primaryContainer, theme.primaryContainer],
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
          border: Border.all(color: theme.onPrimary),
        ),

        child: Row(
          children: [
            buildImage(theme, art, 5.h, 5.h),
            SizedBox(width: 1.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildTitle(context), _buildSubtitle(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return searchedWord != null
        ? formattedText(
            corpus: title!,
            searchedWord: searchedWord!,
            context: context,
          )
        : Text(title!, maxLines: 1, overflow: TextOverflow.ellipsis);
  }

  Text _buildSubtitle(BuildContext context) {
    return artist == null
        ? Text('')
        : searchedWord != null
        ? formattedText(
            corpus: title!,
            searchedWord: searchedWord!,
            context: context,
          )
        : Text(artist!, overflow: TextOverflow.ellipsis, maxLines: 1);
  }
}
