import 'package:bloc/bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/session/session_event.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';
import 'package:moneygement_app/modules/authentication/domain/usecases/logout.dart';

part 'session_state.dart';

@lazySingleton
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Logout _logout;

  SessionBloc(this._logout) : super(const SessionIdle(null)) {
    on<SetCurrentUserEvent>(_setCurrentUser);
    on<LogoutEvent>(_logoutUser);
  }

  void _setCurrentUser(SetCurrentUserEvent event, Emitter<SessionState> emit) {
    emit(SessionIdle(event.user));
  }

  void _logoutUser(LogoutEvent event, Emitter<SessionState> emit) async {
    await _logout();
    emit(SessionLogout(event.user));
  }
}
