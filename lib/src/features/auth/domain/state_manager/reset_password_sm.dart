import 'package:aniliberty_multiplatform/src/features/auth/domain/repository/auth_repository.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/reset_password_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template reset_password_sm}
/// State manager for reset password process
/// {@endtemplate}
class ResetPasswordSM extends StateManager<ResetPasswordState> {
  final IAuthRepository _repository;

  /// {@macro reset_password_sm}
  ResetPasswordSM({
    required this._repository,
  }) : super(const ResetPasswordState.idle());

  /// Reset password with token
  ///
  /// [token] - Token from email
  /// [password] - New password
  /// [passwordConfirmation] - Password confirmation
  void resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) => handle(
    (emit) async {
      emit(const ResetPasswordState.progress());

      try {
        await _repository.resetPassword(
          token: token,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );

        emit(const ResetPasswordState.success());
      } on Object catch (error, stackTrace) {
        emit(const ResetPasswordState.error());
        addError(error, stackTrace);
      } finally {
        emit(const ResetPasswordState.idle());
      }
    },
    identifier: 'resetPassword',
  );
}
