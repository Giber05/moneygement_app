part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class GetQuizEvent extends QuizEvent {}

class CachedQuizzesEvent extends QuizEvent {
  final List<QuizModel> quizzes;

  const CachedQuizzesEvent(this.quizzes);
}
