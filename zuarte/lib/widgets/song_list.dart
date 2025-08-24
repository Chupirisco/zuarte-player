import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zuarte/widgets/song_item.dart';

import '../utils/style_configs.dart';

class SongList extends StatelessWidget {
  final List<MediaItem> songs;
  final SongHandler songHandler;
  final AutoScrollController autoScrollController;
  const SongList({
    super.key,
    required this.songs,
    required this.songHandler,
    required this.autoScrollController,
  });

  @override
  Widget build(BuildContext context) {
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
            controller: autoScrollController,
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
                      ? _buildRegularSongItem(song, playingSong)
                      : AutoScrollTag(
                          key: ValueKey(index),
                          controller: autoScrollController,
                          index: index,
                          child: _buildLastSongItem(song, playingSong),
                        );
                },
              );
            },
          );
  }

  Widget _buildLastSongItem(MediaItem song, MediaItem? playingSong) {
    return Column(
      children: [
        SongItem(
          isPlaying: song == playingSong,
          id: int.parse(song.displayDescription!),
          artist: song.artist,
          title: song.title,
          art: song.artUri,
          onSongTap: () async {
            await songHandler.skipToQueueItem(songs.length - 1);
          },
        ),
      ],
    );
  }

  Widget _buildRegularSongItem(MediaItem song, MediaItem? playingSong) {
    return SongItem(
      isPlaying: song == playingSong,
      id: int.parse(song.displayDescription!),
      artist: song.artist,
      title: song.title,
      art: song.artUri,
      onSongTap: () async {
        await songHandler.skipToQueueItem(songs.indexOf(song));
      },
    );
  }
}
