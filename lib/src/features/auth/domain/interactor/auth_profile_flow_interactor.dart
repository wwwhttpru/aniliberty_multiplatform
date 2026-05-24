import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/profile.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template auth_profile_flow_interactor}
/// Interactor for handling the profile flow
/// {@endtemplate}
class AuthProfileFlowInteractor {
  /// {@macro auth_sm}
  final AuthSM _authSM;

  /// {@macro profile_container_holder}
  final ProfileContainerHolder _profileContainerHolder;

  /// {@macro profile_container_input_scope}
  final ProfileContainerInputScope _profileContainerInputScope;

  /// Subscription to changes in the auth state
  StreamSubscription<void>? _onAuthSub;

  /// {@macro auth_profile_flow_interactor}
  AuthProfileFlowInteractor({
    required this._authSM,
    required this._profileContainerHolder,
    required this._profileContainerInputScope,
  });

  @mustCallSuper
  Future<void> init() async {
    assert(
      _onAuthSub == null,
      'onAuthSub must be null',
    );

    _onAuthSub = _authSM.stream
        .startWith(_authSM.state)
        .map((event) => event.isAuthenticated)
        .distinct()
        .asyncMap(_onAuth)
        .listen(null);
  }

  @mustCallSuper
  Future<void> dispose() async {
    assert(
      _onAuthSub != null,
      'onAuthSub must not be null',
    );
    await _onAuthSub?.cancel();
    _onAuthSub = null;

    // Drop profile container if it is available
    await _dropProfileContainer();
  }

  Future<void> _onAuth(bool isAuthenticated) async {
    if (isAuthenticated) {
      await _profileContainerHolder.create(_profileContainerInputScope);
      return;
    }

    await _dropProfileContainer();
    return;
  }

  Future<void> _dropProfileContainer() async {
    final state = _profileContainerHolder.state;
    if (state.none || state.disposing) {
      return;
    }

    await _profileContainerHolder.drop();
  }
}
