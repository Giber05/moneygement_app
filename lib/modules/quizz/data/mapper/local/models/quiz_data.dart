import 'package:moneygement_app/modules/quizz/domain/models/quiz_data.dart';
import 'package:hive/hive.dart';
part 'quiz_data.g.dart';

@HiveType(typeId: 1)
class QuizData extends QuizDataModel {
  @HiveField(0)
  final String? text;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? value;

  QuizData({
    this.text,
    this.name,
    this.value,
  }) : super(
          text: text,
          name: name,
          value: value,
        );

  @override
  List<Object?> get props => [text, name, value];
}
