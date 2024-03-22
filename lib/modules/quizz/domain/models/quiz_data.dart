import 'package:equatable/equatable.dart';

class QuizDataModel extends Equatable {
  final String? text;
  final String? name;
  final String? value;

  QuizDataModel({
    this.text,
    this.name,
    this.value,
  });

  @override
  List<Object?> get props => [text, name, value];
}
