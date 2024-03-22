import 'package:moneygement_app/modules/quizz/data/datasource/local/quiz_local_dts.dart';
import 'package:moneygement_app/modules/quizz/data/datasource/remote/quiz_remote_dts.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:moneygement_app/modules/quizz/domain/repositories/quiz_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: QuizRepo)
class QuizRepoImpl implements QuizRepo {
  final QuizRemoteDts _quizRemoteDts;
  final QuizLocalDts _quizLocalDts;

  QuizRepoImpl(this._quizRemoteDts, this._quizLocalDts);

  @override
  Future<List<QuizModel>> getQuizData() async {
    final getQuizResult = await _quizRemoteDts.getQuizData();
    return getQuizResult.data;
  }

  @override
  Future<void> cacheQuizzes(String key, List<QuizModel> quizzes) async {
    await _quizLocalDts.cacheQuizzes(key, quizzes);
  }

  @override
  Future<List<QuizModel>> getCachedQuizzes(String key) async {
    return await _quizLocalDts.getCachedQuizzes(key);
  }
}
