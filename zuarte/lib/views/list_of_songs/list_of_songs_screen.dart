import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/model/music_model.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/viewmodels/miniplayer_controller_provider.dart';
import 'package:zuarte/widgets/cards.dart';

import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({super.key});

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  final height = 100.h;

  @override
  Widget build(BuildContext context) {
    final listSongs = context.select<AudioPlayerProvider, List<MusicModel>>(
      (p) => p.listSongs,
    );
    final idCurrentMusic = context.select<AudioPlayerProvider, int>(
      (provider) => provider.idCurrentMusic,
    );

    final ColorScheme theme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Text(
            'Minhas músicas',
            style: textStyle(
              size: 18,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.01),
          listSongs.isNotEmpty
              ? Expanded(
                  child: ScrollablePositionedList.builder(
                    physics: scrollEffect(),
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    minCacheExtent: 50,
                    padding: EdgeInsets.zero,
                    itemCount: listSongs.length,
                    itemBuilder: (context, index) {
                      final music = listSongs[index]; // Sem watch aqui!

                      bool isSelected = music.id == idCurrentMusic;

                      return GestureDetector(
                        onTap: () {
                          context.read<AudioPlayerProvider>().setPlaylist(
                            music.id,
                          );
                          context
                              .read<MiniplayerControllerProvider>()
                              .expandedMiniPlayer(music);
                        },
                        child: musicCard(
                          isSelected: isSelected,
                          context: context,
                          theme: theme,
                          onOptions: true,
                          music: music,
                        ),
                      );
                    },
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nenhuma música por aqui',
                    style: textStyle(
                      size: 15,
                      color: theme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          SizedBox(height: 13.h),
        ],
      ),
    );
  }
}
