import 'package:audio_service/audio_service.dart';
import 'package:hive/hive.dart';
import 'hive_media_item_model.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 0)
class PlaylistModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  List<HiveMediaItem> songs;

  @HiveField(3)
  String? artUriPath;

  PlaylistModel({
    required this.id,
    required this.nome,
    required this.songs,
    this.artUriPath,
  });

  Uri? get artUri => artUriPath != null ? Uri.tryParse(artUriPath!) : null;

  int get numMusicas => songs.length;

  List<MediaItem> get mediaItems => songs.map((s) => s.toMediaItem()).toList();
}
