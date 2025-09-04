import 'package:hive/hive.dart';
import '../model/song.dart';

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    return Song(
      id: reader.readString(),
      title: reader.readString(),
      artist: reader.readString(),
      path: reader.readString(),
      duration: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.artist);
    writer.writeString(obj.path);
    writer.writeInt(obj.duration);
  }
}
