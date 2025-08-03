import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

Future<List<SongModel>> searchMusic() async {
  bool allowed = await _audioQuery.permissionsStatus();
  if (!allowed) {
    allowed = await _audioQuery.permissionsRequest();
  }

  if (!allowed) return [];

  List<SongModel> songs = await _audioQuery.querySongs();

  return songs;
}
