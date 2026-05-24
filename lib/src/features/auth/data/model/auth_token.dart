import 'package:meta/meta.dart';

/// {@template auth_token}
/// Data model for authentication token
/// {@endtemplate}
@immutable
class AuthToken {
  /// Authorization token value
  final String token;

  /// {@macro auth_token}
  const AuthToken({required this.token});

  /// Generate Class from Map<String, Object?>
  factory AuthToken.fromJson(Map<String, Object?> json) {
    if (json['token'] case final String token) {
      return AuthToken(token: token);
    }

    throw Exception('Invalid JSON: $json');
  }

  /// Convert to Map<String, Object?>
  Map<String, Object?> toJson() => {'token': token};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthToken && other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
