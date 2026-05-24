import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response_model.freezed.dart';
part 'auth_login_response_model.g.dart';

@freezed
abstract class AuthLoginResponseModel with _$AuthLoginResponseModel {
  const factory AuthLoginResponseModel({
    /// Authorization token
    ///
    /// example: eyJpdiI6IjlhZTBTaU9QZ0pUQ0E5YzZzYzhWRWc9PSIsInZhbHVlIjoiSFZaVHF6Sm45UVBCVk13U1hFYWpRdm1IL0xWWTFpTCtKUUpacDhqSk9LZEY1N0R1MURsN3A5VWRvUFp2OU5YYSIsIm1hYyI6IjUyYTM1NmM5ZGNkNGRiOTFiZmM3Y2FhZmY1ZGQ2MTAzOTc4MDNlMGM2MDg1OWNiMjFlODRiNGIyZGRiNTU1YTIifQ==
    @JsonKey(name: 'token') required String token,
  }) = _AuthLoginResponseModel;

  /// Generate Class from Map<String, Object?>
  factory AuthLoginResponseModel.fromJson(Map<String, Object?> json) =>
      _$AuthLoginResponseModelFromJson(json);
}
