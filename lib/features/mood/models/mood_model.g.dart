// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodModelAdapter extends TypeAdapter<MoodModel> {
  @override
  final int typeId = 1;

  @override
  MoodModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MoodModel.awful;
      case 1:
        return MoodModel.bad;
      case 2:
        return MoodModel.neutral;
      case 3:
        return MoodModel.good;
      case 4:
        return MoodModel.awesome;
      default:
        return MoodModel.awful;
    }
  }

  @override
  void write(BinaryWriter writer, MoodModel obj) {
    switch (obj) {
      case MoodModel.awful:
        writer.writeByte(0);
        break;
      case MoodModel.bad:
        writer.writeByte(1);
        break;
      case MoodModel.neutral:
        writer.writeByte(2);
        break;
      case MoodModel.good:
        writer.writeByte(3);
        break;
      case MoodModel.awesome:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
