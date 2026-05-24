import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/domain/interactor/auth_navigation_interactor.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/login_state.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state_manager/login_sm.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template auth_login_flow_interactor}
/// Interactor for handling login flow
///
/// Subscribes to [LoginSM] and closes the login screen
/// when authentication is successful.
/// {@endtemplate}
class AuthLoginFlowInteractor {
  /// {@macro login_sm}
  final LoginSM _loginSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  /// Subscription to login state changes
  StreamSubscription<LoginState>? _onLoginStateSub;

  /// {@macro auth_login_flow_interactor}
  AuthLoginFlowInteractor({
    required this._loginSM,
    required this._navigationInteractor,
  });

  /// Initialize the interactor
  ///
  /// Starts listening to login state changes.
  @mustCallSuper
  Future<void> init() async {
    assert(
      _onLoginStateSub == null,
      'onLoginStateSub must be null',
    );

    _onLoginStateSub = _loginSM.stream
        .startWith(_loginSM.state)
        .distinct()
        .listen(_onLoginState);
  }

  /// Close the interactor
  ///
  /// Cancels the subscription to login state changes.
  @mustCallSuper
  Future<void> dispose() async {
    assert(
      _onLoginStateSub != null,
      'onLoginStateSub must not be null',
    );

    await _onLoginStateSub?.cancel();
    _onLoginStateSub = null;
  }

  void _onLoginState(LoginState state) {
    if (!state.isSuccess) {
      return;
    }

    _navigationInteractor.closeLogin();
  }
}
