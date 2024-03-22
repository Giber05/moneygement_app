import 'package:moneygement_app/modules/quizz/domain/models/quiz_data.dart';
import 'package:equatable/equatable.dart';

class QuizModel extends Equatable {
  final List<dynamic> question;
  final String questionNumber;
  final String typeQuestion;
  final String name;
  final String value;
  final int grade;
  final List<QuizDataModel> data;

  QuizModel({
    required this.question,
    required this.questionNumber,
    required this.typeQuestion,
    required this.name,
    required this.value,
    required this.grade,
    required this.data,
  });

  @override
  List<Object?> get props => [question, questionNumber, typeQuestion, name, value, grade, data];
}
