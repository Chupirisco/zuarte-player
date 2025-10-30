// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_media_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMediaItemAdapter extends TypeAdapter<HiveMediaItem> {
  @override
  final int typeId = 1;

  @override
  HiveMediaItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMediaItem(
      id: fields[0] as String,
      title: fields[1] as String,
      artist: fields[2] as String?,
      durationMs: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMediaItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.durationMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMediaItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
