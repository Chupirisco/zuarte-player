import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/models/playlist_model.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';
import 'package:zuarte/views/playlist/modal_add_song_to_playlist.dart';

import '../../../services/audio_handler.dart';
import '../../../services/service_locator.dart';
import '../../../widgets/song_list.dart';

class SelectedPlaylistScreen extends StatefulWidget {
  const SelectedPlaylistScreen({super.key, required this.selectedPlaylist});
  final PlaylistModel selectedPlaylist;

  @override
  State<SelectedPlaylistScreen> createState() => _SelectedPlaylistScreenState();
}

class _SelectedPlaylistScreenState extends State<SelectedPlaylistScreen> {
  final songHandler = getIt<SongHandler>();
  @override
  Widget build(BuildContext context) {
    final provPlay = Provider.of<PlaylistProvider>(context);
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin(),
          vertical: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            //header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => {
                    provPlay.deletePlaylist(widget.selectedPlaylist.id),
                    Navigator.of(context).pop(),
                  },
                  icon: Iconify(
                    AppIcons.trash,
                    size: iconSize(20),
                    color: iconColor(theme),
                  ),
                ),
                Text(
                  widget.selectedPlaylist.nome,
                  style: textStyle(
                    size: 20,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Iconify(
                    AppIcons.close,
                    size: iconSize(25),
                    color: iconColor(theme),
                  ),
                ),
              ],
            ),
            //image
            buildImageWidget(widget.selectedPlaylist.artUri, theme),

            // actions and info
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  '${widget.selectedPlaylist.numMusicas} ${widget.selectedPlaylist.numMusicas == 1 ? 'música' : 'músicas'} no total',
                  style: textStyle(size: 14, color: theme.primary),
                ),
                const Spacer(),
                iconsGroup(theme, [
                  IconButton(
                    onPressed: () {},
                    icon: Iconify(
                      AppIcons.edit,
                      size: iconSize(20),
                      color: iconColor(theme),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return PopScope(
                            canPop: false,
                            child: ModalAddSongToPlaylist(
                              idPlay: widget.selectedPlaylist.id,
                            ),
                          );
                        },
                      );
                    },
                    icon: Iconify(
                      AppIcons.plus,
                      size: iconSize(20),
                      color: iconColor(theme),
                    ),
                  ),
                ]),
                SizedBox(width: 2.w),
                iconsGroup(theme, [
                  IconButton(
                    onPressed: () {
                      songHandler.setPlaylist(widget.selectedPlaylist.songs);
                    },
                    icon: Iconify(
                      AppIcons.play,
                      size: iconSize(20),
                      color: iconColor(theme),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Iconify(
                      AppIcons.random,
                      size: iconSize(20),
                      color: iconColor(theme),
                    ),
                  ),
                ]),
              ],
            ),

            SizedBox(height: 1.h),
            // list songs
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                'Músicas',
                style: textStyle(
                  size: 16,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SongList(
                songs: widget.selectedPlaylist.songs,
                songHandler: songHandler,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildImageWidget(File? imagem, ColorScheme theme) {
  return ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(18)),
    child: Container(
      height: 20.h,
      width: 100.w,
      color: theme.primaryContainer,

      child: imagem == null
          ? Iconify(AppIcons.person)
          : Image.file(imagem, fit: BoxFit.cover),
    ),
  );
}

Widget iconsGroup(ColorScheme theme, List<Widget> childrem) {
  return Container(
    decoration: BoxDecoration(
      color: theme.primaryContainer,
      borderRadius: BorderRadius.circular(defaultBorderRadius(12)),
    ),

    child: Row(children: childrem),
  );
}
