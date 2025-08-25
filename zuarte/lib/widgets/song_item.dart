import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/services/uri_to_file.dart';
import 'package:zuarte/utils/formatted_text.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class SongItem extends StatelessWidget {
  final String? searchedWord;
  final bool isPlaying;
  final Uri? art;
  final String? title;
  final String? artist;
  final int id;
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
            _buildLeading(theme),
            Column(children: [_buildTitle(context), _buildSubtitle(context)]),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(ColorScheme theme) {
    return FutureBuilder<File?>(
      future: uriToFile(art),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Iconify(AppIcons.alert);
        }
        return Container(
          height: 45,
          width: 45,
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
