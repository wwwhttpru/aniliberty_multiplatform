import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// {@template auth_state}
/// State for authentication status
/// {@endtemplate}
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  /// Returns true if the state is unknown
  bool get isUnknown => maybeMap(
    orElse: () => false,
    unknown: (_) => true,
  );

  /// Returns true if the state is authenticated
  bool get isAuthenticated => maybeMap(
    orElse: () => false,
    authenticated: (_) => true,
  );

  /// Returns true if the state is unauthenticated
  bool get isUnauthenticated => maybeMap(
    orElse: () => false,
    unauthenticated: (_) => true,
  );

  /// Authentication status is unknown (initial state)
  const factory AuthState.unknown() = UnknownAuthState;

  /// User is authenticated
  const factory AuthState.authenticated() = AuthenticatedAuthState;

  /// User is not authenticated
  const factory AuthState.unauthenticated() = UnauthenticatedAuthState;
}
