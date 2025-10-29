import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/services/uri_to_file.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';

class SongItemMark extends StatefulWidget {
  final MediaItem song;
  final bool isDisabled;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;

  const SongItemMark({
    super.key,
    required this.song,
    this.isDisabled = false,
    this.isChecked = false,
    this.onChanged,
  });

  @override
  State<SongItemMark> createState() => _SongItemMarkState();
}

class _SongItemMarkState extends State<SongItemMark> {
  bool? localSelected;

  @override
  void initState() {
    super.initState();
    localSelected = widget.isChecked;
  }

  void mark(PlaylistProvider provPlay) {
    if (widget.isDisabled) return; // impede interação
    setState(() {
      localSelected = !(localSelected ?? false);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(localSelected);
    } else {
      provPlay.manageSongList(widget.song, localSelected ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final provPlay = context.read<PlaylistProvider>();

    final bool isInactive = widget.isDisabled;
    final double opacity = isInactive ? 0.5 : 1.0;

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: isInactive ? null : () => mark(provPlay),
        child: Container(
          margin: EdgeInsets.only(bottom: 0.5.h),
          height: 6.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: theme.primaryContainer,
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
              Checkbox(
                value: localSelected,
                onChanged: isInactive ? null : (value) => mark(provPlay),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(ColorScheme theme) {
    return FutureBuilder<File?>(
      future: uriToFile(widget.song.artUri),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Iconify(AppIcons.alert, color: theme.error);
        }
        return Container(
          margin: const EdgeInsets.only(left: 5),
          height: 5.h,
          width: 5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius(14)),
            color: theme.surface,
          ),
          child: snapshot.data == null
              ? Iconify(AppIcons.person, color: theme.primary)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius(14)),
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
    final theme = Theme.of(context).colorScheme;
    return Text(
      widget.song.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: widget.isDisabled ? theme.outline : theme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _buildSubtitle(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return widget.song.artist == null
        ? const Text('')
        : Text(
            widget.song.artist!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: widget.isDisabled ? theme.outline : theme.secondary,
            ),
          );
  }
}
