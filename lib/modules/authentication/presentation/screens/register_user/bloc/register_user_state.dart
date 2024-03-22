part of 'register_user_bloc.dart';

sealed class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object> get props => [];
}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserLoading extends RegisterUserState {}

final class RegisterUserSuccess extends RegisterUserState {

  const RegisterUserSuccess();
}

final class RegisterUserFailed extends RegisterUserState {
  final String message;

  const RegisterUserFailed({required this.message});
}
