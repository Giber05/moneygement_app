part of 'register_user_bloc.dart';

sealed class RegisterUserEvent extends Equatable {
  const RegisterUserEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserRequested extends RegisterUserEvent {
  final String email;
  final String password;
  final String name;

  const RegisterUserRequested({required this.email, required this.password, required this.name});
}
