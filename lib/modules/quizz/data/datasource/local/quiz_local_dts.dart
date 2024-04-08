import 'package:moneygement_app/infrastructure/local_storage/hive/hive_local_storage.dart';
import 'package:moneygement_app/modules/quizz/data/mapper/local/models/quiz.dart';
import 'package:moneygement_app/modules/quizz/data/mapper/local/models/quiz_data.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_data.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:injectable/injectable.dart';

abstract class QuizLocalDts {
  Future<List<QuizModel>> getCachedQuizzes(String key);
  Future<void> cacheQuizzes(String key, List<QuizModel> quizzes);
}

@Injectable(as: QuizLocalDts)
class QuizLocalDtsImpl implements QuizLocalDts {
  final HiveLocalStorage _hiveLocalStorage;

  QuizLocalDtsImpl(this._hiveLocalStorage);

  @override
  Future<void> cacheQuizzes(String key, List<QuizModel> quizzes) async {
    final quizzesToCache = quizzes
        .map((quiz) => Quiz(
              question: quiz.question,
              questionNumber: quiz.questionNumber,
              typeQuestion: quiz.typeQuestion,
              name: quiz.name,
              value: quiz.value,
              grade: quiz.grade,
              data: quiz.data.map((e) => QuizData(name: e.name, text: e.text, value: e.value)).toList(),
            ))
        .toList();

    await _hiveLocalStorage.saveData(key, quizzesToCache);
    getCachedQuizzes('quizzes');
  }

  @override
  Future<List<QuizModel>> getCachedQuizzes(String key) async {
    final List<Quiz> quizzLocalResult = await _hiveLocalStorage.readData(key);
    final result = quizzLocalResult
        .map((e) => QuizModel(
            question: e.question,
            questionNumber: e.questionNumber,
            typeQuestion: e.typeQuestion,
            name: e.name,
            value: e.value,
            grade: e.grade,
            data: e.data
                .map((v) => QuizDataModel(
                      name: v.name,
                      text: v.text,
                      value: v.value,
                    ))
                .toList()))
        .toList();
    return result;
  }
}
