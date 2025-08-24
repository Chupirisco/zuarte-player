import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/widgets/song_list.dart';

import '../../utils/size_config.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({super.key});

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  final height = 100.h;
  final songHandler = GetIt.instance<SongHandler>();
  AutoScrollController autoScrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Consumer<SongProvider>(
        builder: (context, prov, child) {
          return prov.isLoading
              ? _buildLoadingIndicator()
              : _buildSongsList(
                  songHandler: songHandler,
                  songs: prov.songs,
                  autoScrollController: autoScrollController,
                );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round));
  }

  Widget _buildSongsList({
    required SongHandler songHandler,
    required List<MediaItem> songs,
    required AutoScrollController autoScrollController,
  }) {
    return Stack(
      children: [
        SongList(
          songs: songs,
          songHandler: songHandler,
          autoScrollController: autoScrollController,
        ),
      ],
    );
  }
}
