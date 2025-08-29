import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/service_locator.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/widgets/custom_circular_progress_indicator.dart';
import 'package:zuarte/widgets/song_list.dart';

import '../../utils/size_config.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({super.key});

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  final height = 100.h;
  final songHandler = getIt<SongHandler>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Consumer<SongProvider>(
        builder: (context, prov, child) {
          return prov.isLoading
              ? customCircularProgressIndicator(theme)
              : _buildSongsList(songHandler: songHandler, songs: prov.songs);
        },
      ),
    );
  }

  Widget _buildSongsList({
    required SongHandler songHandler,
    required List<MediaItem> songs,
  }) {
    return Stack(
      children: [SongList(songs: songs, songHandler: songHandler)],
    );
  }
}
