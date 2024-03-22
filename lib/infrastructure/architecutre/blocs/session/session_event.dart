import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

sealed class SessionEvent {}

class SetCurrentUserEvent extends SessionEvent {
  final UserSessionModel? user;

  SetCurrentUserEvent(this.user);
}

class LogoutEvent extends SessionEvent {
  final UserSessionModel? user;

  LogoutEvent(this.user);
}

