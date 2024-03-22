import 'package:bloc/bloc.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/authentication/presentation/screens/login/bloc/login_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';
import 'package:moneygement_app/modules/authentication/domain/usecases/login.dart';

part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey formKey = GlobalKey();

  LoginBloc(this._login) : super(LoginInIdle()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    final result = await _login(LoginParams(email: event.email, password: event.password));
    switch (result) {
      case Success(data: UserSessionModel data):
        emit(LoginSuccess(data));
      case Error():
        emit(LoginError(result.exception.message));
    }
  }

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    return super.close();
  }
}
