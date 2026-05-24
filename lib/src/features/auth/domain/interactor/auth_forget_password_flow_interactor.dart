import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/domain/interactor/auth_navigation_interactor.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/forget_password_state.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state_manager/forget_password_sm.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template auth_forget_password_flow_interactor}
/// Interactor for handling forget password flow
///
/// Subscribes to [ForgetPasswordSM] and closes the forget password screen
/// when email is sent successfully.
/// {@endtemplate}
class AuthForgetPasswordFlowInteractor {
  /// {@macro forget_password_sm}
  final ForgetPasswordSM _forgetPasswordSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  /// Subscription to forget password state changes
  StreamSubscription<ForgetPasswordState>? _onForgetPasswordStateSub;

  /// {@macro auth_forget_password_flow_interactor}
  AuthForgetPasswordFlowInteractor({
    required this._forgetPasswordSM,
    required this._navigationInteractor,
  });

  /// Initialize the interactor
  ///
  /// Starts listening to forget password state changes.
  @mustCallSuper
  Future<void> init() async {
    assert(
      _onForgetPasswordStateSub == null,
      'onForgetPasswordStateSub must be null',
    );

    _onForgetPasswordStateSub = _forgetPasswordSM.stream
        .startWith(_forgetPasswordSM.state)
        .distinct()
        .listen(_onForgetPasswordState);
  }

  /// Close the interactor
  ///
  /// Cancels the subscription to forget password state changes.
  @mustCallSuper
  Future<void> dispose() async {
    assert(
      _onForgetPasswordStateSub != null,
      'onForgetPasswordStateSub must not be null',
    );

    await _onForgetPasswordStateSub?.cancel();
    _onForgetPasswordStateSub = null;
  }

  void _onForgetPasswordState(ForgetPasswordState state) {
    if (!state.isSuccess) {
      return;
    }

    _navigationInteractor.closeForgetPassword();
  }
}
