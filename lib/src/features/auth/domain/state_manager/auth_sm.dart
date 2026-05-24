import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/domain/repository/auth_repository.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/auth_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template auth_sm}
/// State manager for authentication status
/// {@endtemplate}
class AuthSM extends StateManager<AuthState> {
  /// {@macro i_auth_repository}
  final IAuthRepository _repository;

  /// Subscription to authentication state changes
  StreamSubscription<bool>? _authSubscription;

  /// {@macro auth_sm}
  AuthSM({
    required this._repository,
  }) : super(const AuthState.unknown());

  /// Initialize auth state manager
  Future<void> init() async {
    assert(
      _authSubscription == null,
      'AuthSubscription must be null',
    );

    // Subscribe to authentication state changes
    _authSubscription = _repository.isAuthenticatedStream.listen(
      _onAuthStateChanged,
    );

    // Check initial authentication state
    return _readAuthState();
  }

  /// Close auth state manager
  @override
  Future<void> close() async {
    assert(
      _authSubscription != null,
      'AuthSubscription must not be null',
    );

    await _authSubscription?.cancel();
    _authSubscription = null;
    return super.close();
  }

  void _readAuthState() {
    handle(
      (emit) async {
        try {
          final isAuthenticated = await _repository.readIsAuthenticated();
          final next = switch (isAuthenticated) {
            true => const AuthState.authenticated(),
            false => const AuthState.unauthenticated(),
          };
          emit(next);
        } on Object catch (error, stackTrace) {
          addError(error, stackTrace);
          emit(const AuthState.unauthenticated());
        }
      },
      identifier: '_readAuthState',
    );
  }

  void _onAuthStateChanged(bool isAuthenticated) {
    handle(
      (emit) async {
        final next = switch (isAuthenticated) {
          true => const AuthState.authenticated(),
          false => const AuthState.unauthenticated(),
        };
        emit(next);
      },
      identifier: '_onAuthStateChanged',
    );
  }
}
