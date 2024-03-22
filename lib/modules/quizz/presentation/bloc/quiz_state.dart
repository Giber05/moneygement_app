part of 'quiz_bloc.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

final class QuizInitial extends QuizState {}

final class GetQuizLoading extends QuizState {}

final class GetQuizSuccess extends QuizState {
  final List<QuizModel> quizData;

  const GetQuizSuccess(this.quizData);
  @override
  List<Object> get props => [quizData];
}

final class GetQuizFailed extends QuizState {
  final String message;

  const GetQuizFailed(this.message);
}
