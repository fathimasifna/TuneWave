// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsModelAdapter extends TypeAdapter<SongsModel> {
  @override
  final int typeId = 0;

  @override
  SongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsModel(
      title: fields[1] as String?,
      subtitle: fields[2] as String?,
      id: fields[0] as int?,
      isFavorite: fields[3] as bool,
      audioUri: fields[4] as String?,
      imageUri: fields[5] as String?, name: '',
    );
  }

  @override
  void write(BinaryWriter writer, SongsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.isFavorite)
      ..writeByte(4)
      ..write(obj.audioUri)
      ..writeByte(5)
      ..write(obj.imageUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
