import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/services/uri_to_file.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';

class SongItemMark extends StatefulWidget {
  final MediaItem song;

  const SongItemMark({super.key, required this.song});

  @override
  State<SongItemMark> createState() => _SongItemMarkState();
}

class _SongItemMarkState extends State<SongItemMark> {
  bool isSelected = false;

  void mark(PlaylistProvider provPlay) {
    setState(() {
      isSelected = !isSelected;
    });

    provPlay.manageSongList(widget.song, isSelected);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final provPlay = context.read<PlaylistProvider>();

    return GestureDetector(
      onTap: () => mark(provPlay),

      child: Container(
        margin: EdgeInsets.only(bottom: 0.5.h),
        height: 6.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
          border: Border.all(color: theme.onPrimary),
        ),

        child: Row(
          children: [
            _buildLeading(theme),
            SizedBox(width: 1.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildTitle(context), _buildSubtitle(context)],
              ),
            ),

            Checkbox(value: isSelected, onChanged: (value) => mark(provPlay)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(ColorScheme theme) {
    return FutureBuilder<File?>(
      future: uriToFile(widget.song.artUri),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Iconify(AppIcons.alert);
        }
        return Container(
          margin: EdgeInsets.only(left: 5),
          height: 5.h,
          width: 5.h,
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

  Text _buildTitle(BuildContext context) {
    return Text(
      widget.song.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _buildSubtitle(BuildContext context) {
    return widget.song.artist == null
        ? Text('')
        : Text(
            widget.song.artist!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
  }
}
