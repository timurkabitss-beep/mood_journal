// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeelingModelAdapter extends TypeAdapter<FeelingModel> {
  @override
  final int typeId = 3;

  @override
  FeelingModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FeelingModel.happy;
      case 1:
        return FeelingModel.down;
      case 2:
        return FeelingModel.bored;
      case 3:
        return FeelingModel.angry;
      case 4:
        return FeelingModel.blessed;
      case 5:
        return FeelingModel.inspired;
      case 6:
        return FeelingModel.anxious;
      case 7:
        return FeelingModel.proud;
      case 8:
        return FeelingModel.focused;
      case 9:
        return FeelingModel.chill;
      case 10:
        return FeelingModel.confused;
      case 11:
        return FeelingModel.awkward;
      case 12:
        return FeelingModel.good;
      default:
        return FeelingModel.happy;
    }
  }

  @override
  void write(BinaryWriter writer, FeelingModel obj) {
    switch (obj) {
      case FeelingModel.happy:
        writer.writeByte(0);
        break;
      case FeelingModel.down:
        writer.writeByte(1);
        break;
      case FeelingModel.bored:
        writer.writeByte(2);
        break;
      case FeelingModel.angry:
        writer.writeByte(3);
        break;
      case FeelingModel.blessed:
        writer.writeByte(4);
        break;
      case FeelingModel.inspired:
        writer.writeByte(5);
        break;
      case FeelingModel.anxious:
        writer.writeByte(6);
        break;
      case FeelingModel.proud:
        writer.writeByte(7);
        break;
      case FeelingModel.focused:
        writer.writeByte(8);
        break;
      case FeelingModel.chill:
        writer.writeByte(9);
        break;
      case FeelingModel.confused:
        writer.writeByte(10);
        break;
      case FeelingModel.awkward:
        writer.writeByte(11);
        break;
      case FeelingModel.good:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeelingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
