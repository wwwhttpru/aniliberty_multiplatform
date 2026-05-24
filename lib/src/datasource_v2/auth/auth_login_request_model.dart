import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_request_model.freezed.dart';
part 'auth_login_request_model.g.dart';

@freezed
abstract class AuthLoginRequestModel with _$AuthLoginRequestModel {
  const factory AuthLoginRequestModel({
    /// User login
    ///
    /// example: animeshnik_488
    @JsonKey(name: 'login') required String login,

    /// User password
    ///
    /// example: password
    @JsonKey(name: 'password') required String password,
  }) = _AuthLoginRequestModel;

  /// Generate Class from Map<String, Object?>
  factory AuthLoginRequestModel.fromJson(Map<String, Object?> json) =>
      _$AuthLoginRequestModelFromJson(json);
}
