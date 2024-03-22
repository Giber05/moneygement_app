import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:moneygement_app/modules/quizz/domain/repositories/quiz_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetQuizData extends UsecaseNoParams<List<QuizModel>> {
  final QuizRepo _quizRepo;

  GetQuizData(this._quizRepo);

  @override
  Future<Resource<List<QuizModel>>> execute() => _quizRepo.getQuizData().asResource;
}
