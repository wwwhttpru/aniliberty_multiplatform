import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status_model.freezed.dart';
part 'app_status_model.g.dart';

/// App status request information
@freezed
abstract class AppStatusRequestModel with _$AppStatusRequestModel {
  const factory AppStatusRequestModel({
    /// IP address
    /// example: 192.168.1.1
    @JsonKey(name: 'ip') required String ip,

    /// Country name
    /// example: Russia
    @JsonKey(name: 'country') required String country,

    /// ISO country code
    /// example: RU
    @JsonKey(name: 'iso_code') required String isoCode,

    /// Timezone
    /// example: Europe/Moscow
    @JsonKey(name: 'timezone') required String timezone,
  }) = _AppStatusRequestModel;

  /// Generate Class from Map<String, Object?>
  factory AppStatusRequestModel.fromJson(Map<String, Object?> json) =>
      _$AppStatusRequestModelFromJson(json);
}

/// App status response model
@freezed
abstract class AppStatusModel with _$AppStatusModel {
  const factory AppStatusModel({
    /// Request information
    @JsonKey(name: 'request') required AppStatusRequestModel request,

    /// Is service alive
    /// example: true
    @JsonKey(name: 'is_alive') required bool isAlive,

    /// Available API endpoints
    /// example: ["https://aniliberty.top"]
    @JsonKey(name: 'available_api_endpoints')
    required List<String> availableApiEndpoints,
  }) = _AppStatusModel;

  /// Generate Class from Map<String, Object?>
  factory AppStatusModel.fromJson(Map<String, Object?> json) =>
      _$AppStatusModelFromJson(json);
}
