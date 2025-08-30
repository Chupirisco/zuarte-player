import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
