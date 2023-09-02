// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_played_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostPlayedModelAdapter extends TypeAdapter<MostPlayedModel> {
  @override
  final int typeId = 3;

  @override
  MostPlayedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPlayedModel(
      subtitle: fields[1] as String?,
      title: fields[0] as String,
      uri: fields[2] as String,
    )
      ..isFavorite = fields[3] as bool
      ..playCount = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, MostPlayedModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.isFavorite)
      ..writeByte(4)
      ..write(obj.playCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPlayedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
