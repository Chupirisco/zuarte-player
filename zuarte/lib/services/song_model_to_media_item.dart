import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zuarte/services/download_music_cover_model.dart';

import '../utils/formatted_title.dart';

Future<MediaItem> songModelToMediaItem(SongModel song) async {
  try {
    final Uri? art = await getSongsArt(
      id: song.id,
      type: ArtworkType.AUDIO,
      quality: 100,
      size: 300,
    );

    return MediaItem(
      id: song.uri.toString(),
      artUri: art,
      artist: song.artist,
      duration: Duration(milliseconds: song.duration!),
      displayDescription: song.id.toString(),
      title: formattedTitle(song.title).trim(),
    );
  } catch (e) {
    debugPrint('error converting songmodel to mediaitem: $e');
    return const MediaItem(id: '', title: '');
  }
}
