// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListModelAdapter extends TypeAdapter<PlayListModel> {
  @override
  final int typeId = 2;

  @override
  PlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModel(
      name: fields[1] as String?,
      subtitle: fields[2] as String?,
      id: fields[0] as int?,
      audioUri: fields[3] as String?,
      title: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.audioUri)
      ..writeByte(4)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
