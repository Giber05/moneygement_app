import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:moneygement_app/modules/quizz/domain/repositories/quiz_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';

class GetCachedQuizzesParams {
  final String key;

  GetCachedQuizzesParams({required this.key});
}

@injectable
class GetCachedQuizzes extends Usecase<GetCachedQuizzesParams, List<QuizModel>> {
  final QuizRepo _quizRepo;

  GetCachedQuizzes(this._quizRepo);

  @override
  Future<Resource<List<QuizModel>>> execute(GetCachedQuizzesParams params) async {
    final result = await _quizRepo.getCachedQuizzes(params.key);
    return Resource.success(result);
  }
}
