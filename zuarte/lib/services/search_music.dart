import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

Future<List<SongModel>> searchMusic() async {
  bool allowed = await _audioQuery.permissionsStatus();
  if (!allowed) {
    allowed = await _audioQuery.permissionsRequest();
  }

  if (!allowed) return [];

  List<SongModel> songs = await _audioQuery.querySongs(
    sortType: SongSortType.DATE_ADDED,
    orderType: OrderType.DESC_OR_GREATER,
  );
  songs = songs.where((song) => !song.data.contains("com.whatsapp")).toList();

  return songs;
}
//