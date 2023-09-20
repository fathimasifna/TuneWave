// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentListModelAdapter extends TypeAdapter<RecentListModel> {
  @override
  final int typeId = 1;

  @override
  RecentListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentListModel(
      subtitle: fields[1] as String?,
      id: fields[0] as int?,
      audioUri: fields[2] as String?,
      title: fields[3] as String?,
      time: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.audioUri)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
