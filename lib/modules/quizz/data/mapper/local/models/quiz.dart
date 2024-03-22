import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:hive/hive.dart';
import 'quiz_data.dart';
part 'quiz.g.dart';

@HiveType(typeId: 0)
class Quiz extends QuizModel {
  @HiveField(0)
  final List<dynamic> question;
  @HiveField(1)
  final String questionNumber;
  @HiveField(2)
  final String typeQuestion;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String value;
  @HiveField(5)
  final int grade;
  @HiveField(6)
  final List<QuizData> data;
  Quiz({
    required this.question,
    required this.questionNumber,
    required this.typeQuestion,
    required this.name,
    required this.value,
    required this.grade,
    required this.data,
  }) : super(
          question: question,
          questionNumber: questionNumber,
          typeQuestion: typeQuestion,
          name: name,
          value: value,
          grade: grade,
          data: data,
        );

  @override
  List<Object?> get props => [question, questionNumber, typeQuestion, name, value, grade, data];
}
