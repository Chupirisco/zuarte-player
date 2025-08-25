import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/widgets/song_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../utils/formatted_title.dart';
import '../utils/style_configs.dart';

class SongList extends StatelessWidget {
  final List<MediaItem> songs;
  final SongHandler songHandler;

  const SongList({super.key, required this.songs, required this.songHandler});

  @override
  Widget build(BuildContext context) {
    AutoScrollController autoScrollController = AutoScrollController();
    final ColorScheme theme = Theme.of(context).colorScheme;
    return songs.isEmpty
        ? Align(
            alignment: Alignment.topLeft,
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
            physics: scrollEffect(),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            padding: EdgeInsets.zero,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              MediaItem song = songs[index];
              return StreamBuilder(
                stream: songHandler.mediaItem.stream,
                builder: (context, snapshot) {
                  MediaItem? playingSong = snapshot.data;
                  return index == (songs.length - 1)
                      ? _buildLastSongItem(song, playingSong)
                      : AutoScrollTag(
                          // Utilize AutoScrollTag for automatic scrolling
                          key: ValueKey(index),
                          controller: autoScrollController,
                          index: index,
                          child: _buildRegularSongItem(song, playingSong),
                        );
                },
              );
            },
          );
  }

  Widget _buildLastSongItem(MediaItem song, MediaItem? playingSong) {
    return Column(
      children: [
        // Display the last song item
        SongItem(
          id: int.parse(song.displayDescription!),
          isPlaying: song == playingSong,
          title: formattedTitle(song.title),
          artist: song.artist,
          onSongTap: () async {
            await songHandler.skipToQueueItem(songs.length - 1);
          },
          art: song.artUri,
        ),
        // Display the player deck for controls
      ],
    );
  }

  Widget _buildRegularSongItem(MediaItem song, MediaItem? playingSong) {
    return SongItem(
      id: int.parse(song.displayDescription!),
      isPlaying: song == playingSong,
      title: formattedTitle(song.title),
      artist: song.artist,
      onSongTap: () async {
        print('clicou');
        await songHandler.skipToQueueItem(songs.indexOf(song));
        await songHandler.play();
      },
      art: song.artUri,
    );
  }
}
