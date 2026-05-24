import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/domain/interactor/auth_navigation_interactor.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/reset_password_state.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state_manager/reset_password_sm.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template auth_reset_password_flow_interactor}
/// Interactor for handling reset password flow
///
/// Subscribes to [ResetPasswordSM] and closes the reset password screen
/// when password is reset successfully.
/// {@endtemplate}
class AuthResetPasswordFlowInteractor {
  /// {@macro reset_password_sm}
  final ResetPasswordSM _resetPasswordSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  /// Subscription to reset password state changes
  StreamSubscription<ResetPasswordState>? _onResetPasswordStateSub;

  /// {@macro auth_reset_password_flow_interactor}
  AuthResetPasswordFlowInteractor({
    required this._resetPasswordSM,
    required this._navigationInteractor,
  });

  /// Initialize the interactor
  ///
  /// Starts listening to reset password state changes.
  @mustCallSuper
  Future<void> init() async {
    assert(
      _onResetPasswordStateSub == null,
      'onResetPasswordStateSub must be null',
    );

    _onResetPasswordStateSub = _resetPasswordSM.stream
        .startWith(_resetPasswordSM.state)
        .distinct()
        .listen(_onResetPasswordState);
  }

  /// Close the interactor
  ///
  /// Cancels the subscription to reset password state changes.
  @mustCallSuper
  Future<void> dispose() async {
    assert(
      _onResetPasswordStateSub != null,
      'onResetPasswordStateSub must not be null',
    );

    await _onResetPasswordStateSub?.cancel();
    _onResetPasswordStateSub = null;
  }

  void _onResetPasswordState(ResetPasswordState state) {
    if (!state.isSuccess) {
      return;
    }

    _navigationInteractor.closeResetPassword();
  }
}
