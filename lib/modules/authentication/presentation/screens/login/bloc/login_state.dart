part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInIdle extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserSessionModel session;

  const LoginSuccess(this.session);
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}
