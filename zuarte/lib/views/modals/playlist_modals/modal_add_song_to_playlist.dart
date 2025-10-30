import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import '../../../utils/size_config.dart';
import '../../../utils/style_configs.dart';
import '../../../viewmodels/audio_player_provider.dart';
import '../../../viewmodels/playlist_provider.dart';
import '../../../widgets/buttton_component.dart';
import '../../../widgets/song_item_mark.dart';

class ModalAddSongToPlaylist extends StatefulWidget {
  final String idPlay;
  const ModalAddSongToPlaylist({super.key, required this.idPlay});

  @override
  State<ModalAddSongToPlaylist> createState() => _ModalAddSongToPlaylistState();
}

class _ModalAddSongToPlaylistState extends State<ModalAddSongToPlaylist> {
  @override
  Widget build(BuildContext context) {
    final provPlay = Provider.of<PlaylistProvider>(context, listen: false);
    final playlist = provPlay.getPlaylist(widget.idPlay);
    final existingIds =
        playlist?.songs.map((s) => s.id).toSet() ?? {}; // IDs já na playlist

    final ColorScheme theme = Theme.of(context).colorScheme;

    return MediaQuery.removeViewInsets(
      context: context,
      removeBottom: true,
      child: Dialog(
        insetPadding: EdgeInsets.all(defaultMargin()),
        child: Column(
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 22.sp),
                Text(
                  'Adicionar músicas',
                  style: textStyle(
                    size: 16,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    provPlay.clearSongList();
                    Navigator.of(context).pop();
                  },
                  icon: Iconify(
                    AppIcons.close,
                    size: iconSize(20),
                    color: iconColor(theme),
                  ),
                ),
              ],
            ),

            // Lista de músicas
            Expanded(
              child: Consumer2<SongProvider, PlaylistProvider>(
                builder: (context, provSong, provPlay, child) {
                  final songs = provSong.songs;

                  return ListView.builder(
                    physics: scrollEffect(),
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      final isAlreadyAdded = existingIds.contains(song.id);
                      final isSelectedNow = provPlay.addSongPlaylist.any(
                        (s) => s.id == song.id,
                      );

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: SongItemMark(
                          song: song,
                          isDisabled: isAlreadyAdded,
                          isChecked: isAlreadyAdded || isSelectedNow,
                          onChanged: isAlreadyAdded
                              ? null
                              : (value) {
                                  provPlay.manageSongList(song, value ?? false);
                                },
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 2.h),

            // Botões de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonComponent(
                  surfaceColor: theme.primaryContainer,
                  onClick: () {
                    provPlay.clearSongList();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: textStyle(size: 16, color: theme.primary),
                  ),
                ),
                buttonComponent(
                  surfaceColor: theme.secondaryContainer.withAlpha(200),
                  onClick: () {
                    provPlay.addSong(widget.idPlay);
                    provPlay.clearSongList();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Salvar',
                    style: textStyle(size: 16, color: const Color(0xFFF9F9F9)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
