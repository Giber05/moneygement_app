// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizAdapter extends TypeAdapter<Quiz> {
  @override
  final int typeId = 0;

  @override
  Quiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quiz(
      question: (fields[0] as List).cast<dynamic>(),
      questionNumber: fields[1] as String,
      typeQuestion: fields[2] as String,
      name: fields[3] as String,
      value: fields[4] as String,
      grade: fields[5] as int,
      data: (fields[6] as List).cast<QuizData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Quiz obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.questionNumber)
      ..writeByte(2)
      ..write(obj.typeQuestion)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.grade)
      ..writeByte(6)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
