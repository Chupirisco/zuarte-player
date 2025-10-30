import 'package:hive/hive.dart';
import 'package:audio_service/audio_service.dart';

part 'hive_media_item_model.g.dart';

@HiveType(typeId: 1)
class HiveMediaItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? artist;

  @HiveField(3)
  int? durationMs;

  HiveMediaItem({
    required this.id,
    required this.title,
    this.artist,
    this.durationMs,
  });

  Duration? get duration =>
      durationMs != null ? Duration(milliseconds: durationMs!) : null;

  factory HiveMediaItem.fromMediaItem(MediaItem item) {
    return HiveMediaItem(
      id: item.id,
      title: item.title,
      artist: item.artist,
      durationMs: item.duration?.inMilliseconds,
    );
  }

  MediaItem toMediaItem() {
    return MediaItem(id: id, title: title, artist: artist, duration: duration);
  }
}
