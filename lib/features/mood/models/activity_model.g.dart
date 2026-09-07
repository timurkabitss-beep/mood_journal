// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityModelAdapter extends TypeAdapter<ActivityModel> {
  @override
  final int typeId = 2;

  @override
  ActivityModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ActivityModel.relationship;
      case 1:
        return ActivityModel.friends;
      case 2:
        return ActivityModel.travel;
      case 3:
        return ActivityModel.food;
      case 4:
        return ActivityModel.sport;
      case 5:
        return ActivityModel.health;
      case 6:
        return ActivityModel.family;
      case 7:
        return ActivityModel.work;
      case 8:
        return ActivityModel.school;
      case 9:
        return ActivityModel.camping;
      case 10:
        return ActivityModel.gaming;
      case 11:
        return ActivityModel.pets;
      case 12:
        return ActivityModel.music;
      case 13:
        return ActivityModel.sleep;
      case 14:
        return ActivityModel.weather;
      default:
        return ActivityModel.relationship;
    }
  }

  @override
  void write(BinaryWriter writer, ActivityModel obj) {
    switch (obj) {
      case ActivityModel.relationship:
        writer.writeByte(0);
        break;
      case ActivityModel.friends:
        writer.writeByte(1);
        break;
      case ActivityModel.travel:
        writer.writeByte(2);
        break;
      case ActivityModel.food:
        writer.writeByte(3);
        break;
      case ActivityModel.sport:
        writer.writeByte(4);
        break;
      case ActivityModel.health:
        writer.writeByte(5);
        break;
      case ActivityModel.family:
        writer.writeByte(6);
        break;
      case ActivityModel.work:
        writer.writeByte(7);
        break;
      case ActivityModel.school:
        writer.writeByte(8);
        break;
      case ActivityModel.camping:
        writer.writeByte(9);
        break;
      case ActivityModel.gaming:
        writer.writeByte(10);
        break;
      case ActivityModel.pets:
        writer.writeByte(11);
        break;
      case ActivityModel.music:
        writer.writeByte(12);
        break;
      case ActivityModel.sleep:
        writer.writeByte(13);
        break;
      case ActivityModel.weather:
        writer.writeByte(14);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
