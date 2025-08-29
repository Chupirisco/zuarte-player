import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicModel {
  final int id;
  final int idImage;
  final String title;
  final String? author;
  final Uri? uri;
  final String duration;

  MusicModel({
    required this.id,
    required this.idImage,
    required this.title,
    required this.author,
    required this.uri,
    required this.duration,
  });

  static MusicModel fromSongModel(SongModel song, int id) {
    return MusicModel(
      id: id,
      idImage: song.id,
      title: song.title,
      author: song.artist ?? 'Desconhecido',
      uri: Uri.file(song.data),
      duration: MusicModel.formattedDuration(song.duration),
    );
  }

  static String formattedDuration(int? milliseconds) {
    if (milliseconds == null) return '00:00';
    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

Future<Uri?> getSongsArt({
  required int id,
  required ArtworkType type,
  required int quality,
  required int size,
}) async {
  OnAudioQuery onAudioQuery = OnAudioQuery();
  try {
    final Uint8List? data = await onAudioQuery.queryArtwork(
      id,
      type,
      quality: quality,
      format: ArtworkFormat.JPEG,
      size: size,
    );

    Uri? art;

    if (data != null) {
      final Directory tempDir = Directory.systemTemp;

      final File file = File("${tempDir.path}/$id.jpg");

      await file.writeAsBytes(data);

      art = file.uri;
    }
    return art;
  } catch (e) {
    debugPrint('error fetching song artwork $e');
    return null;
  }
}
