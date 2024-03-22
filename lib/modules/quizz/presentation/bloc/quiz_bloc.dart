import 'package:bloc/bloc.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:moneygement_app/modules/quizz/domain/usecases/cached_quizzes.dart';
import 'package:moneygement_app/modules/quizz/domain/usecases/get_cached_quizzes.dart';
import 'package:moneygement_app/modules/quizz/domain/usecases/get_quiz_data.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

@injectable
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizData _getQuizData;
  final GetCachedQuizzes _getCachedQuizzes;
  final CachedQuizzes _cachedQuizzes;
  QuizBloc(this._getQuizData, this._getCachedQuizzes, this._cachedQuizzes) : super(QuizInitial()) {
    on<CachedQuizzesEvent>(_onCachedQuizData);
    on<GetQuizEvent>(_onGetQuizData);
  }

  Future<void> _onGetQuizData(GetQuizEvent event, Emitter<QuizState> emit) async {
    emit(GetQuizLoading());
    final result = await _getQuizData();

    switch (result) {
      case Success(data: List<QuizModel> quizData):
        emit(GetQuizSuccess(quizData));
      case Error():
        emit(GetQuizFailed(result.exception.message));
      default:
    }
  }

  Future<void> _onCachedQuizData(CachedQuizzesEvent event, Emitter<QuizState> emit) async {
    final currentState = state;
    if (currentState is GetQuizSuccess) {
      final result = await _cachedQuizzes(CachedQuizzesParams(key: 'quizzes', quizzes: currentState.quizData));

      switch (result) {
        case Success(data: List<QuizModel> quizData):
          emit(GetQuizSuccess(quizData));
        case Error():
          emit(GetQuizFailed(result.exception.message));
        default:
      }
    }
  }
}
