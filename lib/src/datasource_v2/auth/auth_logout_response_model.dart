import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_logout_response_model.freezed.dart';
part 'auth_logout_response_model.g.dart';

@freezed
abstract class AuthLogoutResponseModel with _$AuthLogoutResponseModel {
  const factory AuthLogoutResponseModel({
    /// Authorization token (null after logout)
    @JsonKey(name: 'token') String? token,
  }) = _AuthLogoutResponseModel;

  /// Generate Class from Map<String, Object?>
  factory AuthLogoutResponseModel.fromJson(Map<String, Object?> json) =>
      _$AuthLogoutResponseModelFromJson(json);
}
