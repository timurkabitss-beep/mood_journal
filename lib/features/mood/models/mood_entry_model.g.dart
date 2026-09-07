// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntryModelAdapter extends TypeAdapter<MoodEntryModel> {
  @override
  final int typeId = 0;

  @override
  MoodEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntryModel(
      date: fields[0] as DateTime,
      mood: fields[1] as MoodModel,
      activities: (fields[2] as List).cast<ActivityModel>(),
      feelings: (fields[3] as List).cast<FeelingModel>(),
      title: fields[4] as String,
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mood)
      ..writeByte(2)
      ..write(obj.activities)
      ..writeByte(3)
      ..write(obj.feelings)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
