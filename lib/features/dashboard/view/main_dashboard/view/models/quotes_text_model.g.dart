// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_text_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotesTextModelAdapter extends TypeAdapter<QuotesTextModel> {
  @override
  final int typeId = 4;

  @override
  QuotesTextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuotesTextModel(
      id: fields[0] as int,
      textQuotes: fields[1] as String,
      authorQuotes: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuotesTextModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.textQuotes)
      ..writeByte(2)
      ..write(obj.authorQuotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotesTextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
