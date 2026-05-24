import 'package:aniliberty_multiplatform/src/features/auth/domain/repository/auth_repository.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/forget_password_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template forget_password_sm}
/// State manager for forget password process
/// {@endtemplate}
class ForgetPasswordSM extends StateManager<ForgetPasswordState> {
  final IAuthRepository _repository;

  /// {@macro forget_password_sm}
  ForgetPasswordSM({
    required this._repository,
  }) : super(const ForgetPasswordState.idle());

  /// Request password reset
  ///
  /// [email] - User email
  void forgetPassword({
    required String email,
  }) => handle(
    (emit) async {
      emit(const ForgetPasswordState.progress());

      try {
        await _repository.forgetPassword(email: email);

        emit(const ForgetPasswordState.success());
      } on Object catch (error, stackTrace) {
        emit(const ForgetPasswordState.error());
        addError(error, stackTrace);
      } finally {
        emit(const ForgetPasswordState.idle());
      }
    },
    identifier: 'forgetPassword',
  );
}
