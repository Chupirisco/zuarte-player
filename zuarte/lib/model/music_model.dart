import 'package:on_audio_query/on_audio_query.dart';

class MusicModel {
  final int id;
  final String title;
  final String? author;
  final Uri? uri;
  final String duration;

  MusicModel({
    required this.id,
    required this.title,
    required this.author,
    required this.uri,
    required this.duration,
  });

  static Future<MusicModel> fromSongModel(SongModel song) async {
    return MusicModel(
      id: song.id,
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
