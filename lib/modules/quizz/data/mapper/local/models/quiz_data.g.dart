// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizDataAdapter extends TypeAdapter<QuizData> {
  @override
  final int typeId = 1;

  @override
  QuizData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizData(
      text: fields[0] as String?,
      name: fields[1] as String?,
      value: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuizData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
