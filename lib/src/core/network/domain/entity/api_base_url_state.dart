import 'package:meta/meta.dart';

/// {@template api_base_url_state}
/// State of the API base URL.
/// {@endtemplate}
@immutable
class ApiBaseUrlState {
  /// Base URL.
  final String baseUrl;

  /// {@macro api_base_url_status}
  final ApiBaseUrlStatus status;

  /// Last updated at.
  final DateTime updatedAt;

  /// {@macro api_base_url_state}
  const ApiBaseUrlState({
    required this.baseUrl,
    required this.status,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiBaseUrlState &&
        other.baseUrl == baseUrl &&
        other.status == status &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(baseUrl, status, updatedAt);
}

/// {@template api_base_url_status}
/// Status of the API base URL.
/// {@endtemplate}
enum ApiBaseUrlStatus {
  /// Unknown status.
  unknown,

  /// Success status.
  success,

  /// Failed status.
  failed
  ;

  /// Returns true if the status is unknown.
  bool get isUnknown => this == unknown;

  /// Returns true if the status is success.
  bool get isSuccess => this == success;

  /// Returns true if the status is failed.
  bool get isFailed => this == failed;
}
