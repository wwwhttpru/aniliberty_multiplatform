import 'package:aniliberty_multiplatform/src/features/auth/domain/repository/auth_repository.dart';
import 'package:aniliberty_multiplatform/src/features/profile/domain/state/log_out_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template log_out_sm}
/// State manager for logout feature
/// {@endtemplate}
final class LogOutSM extends StateManager<LogOutState> {
  /// {@macro i_auth_repository}
  final IAuthRepository _repository;

  /// {@macro log_out_sm}
  LogOutSM({
    required this._repository,
  }) : super(const LogOutState.idle());

  /// Log out user
  void logOut() => handle(
    (emit) async {
      emit(const LogOutState.progress());
      try {
        await _repository.logout();
        emit(const LogOutState.success());
      } on Object catch (error, stackTrace) {
        addError(error, stackTrace);
        emit(const LogOutState.error());
      } finally {
        emit(const LogOutState.idle());
      }
    },
    identifier: 'logOut',
  );
}
