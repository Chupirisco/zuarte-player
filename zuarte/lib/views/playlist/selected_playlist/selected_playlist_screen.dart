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

class SelectedPlaylistScreen extends StatefulWidget {
  const SelectedPlaylistScreen({super.key, required this.selectedPlaylist});
  final PlaylistModel selectedPlaylist;

  @override
  State<SelectedPlaylistScreen> createState() => _SelectedPlaylistScreenState();
}

class _SelectedPlaylistScreenState extends State<SelectedPlaylistScreen> {
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
            Row(
              children: [
                Text(
                  '${widget.selectedPlaylist.numMusicas} ${widget.selectedPlaylist.numMusicas == 1 ? 'música' : 'músicas'} no total',
                ),
                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: Iconify(
                    AppIcons.edit,
                    size: iconSize(20),
                    color: iconColor(theme),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Iconify(
                    AppIcons.plus,
                    size: iconSize(20),
                    color: iconColor(theme),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
              ],
            ),

            // list songs
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: widget.selectedPlaylist.songs.isEmpty
                    ? Align(
                        alignment: AlignmentGeometry.topCenter,
                        child: Text(
                          'Nenhuma música por aqui',
                          style: textStyle(
                            size: 15,
                            color: theme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: widget.selectedPlaylist.songs.length,
                        itemBuilder: (context, index) {
                          final song = widget.selectedPlaylist.songs[index];
                          return ListTile(
                            title: Text(song.title),
                            subtitle: Text(
                              song.artist ?? 'Artista desconhecido',
                            ),
                          );
                        },
                      ),
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
