import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';
import 'package:moneygement_app/modules/authentication/domain/usecases/get_current_session.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetCurrentSession _getCurrentSession;
  SplashCubit(this._getCurrentSession) : super(SplashInitial());

  void getLastSession() async {
    emit(SplashInitial());
    final result = await _getCurrentSession.execute();
    await Future.delayed(const Duration(seconds: 2));
    switch (result) {
      case Success():
        emit(SplashSuccess(result.data));
      case Error():
        emit(const SplashSuccess(null));
    }
  }
}
