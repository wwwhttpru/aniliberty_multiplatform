// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

/// User profile model
@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    /// User ID
    /// example: 4837362
    @JsonKey(name: 'id') required int id,

    /// User login
    /// example: animeshnik_488
    /// Отображается только собственный
    @JsonKey(name: 'login') required String login,

    /// User email
    /// example: animeshnik_488@protonmail.com
    /// Отображается только собственный
    @JsonKey(name: 'email') required String email,

    /// User nickname
    /// example: Animeshnik488
    @JsonKey(name: 'nickname') required String nickname,

    /// User avatar
    @JsonKey(name: 'avatar') PosterPreviewModel? avatar,

    /// Torrents data
    @JsonKey(name: 'torrents') UserProfileTorrentsModel? torrents,

    /// Is user banned
    /// example: true
    @JsonKey(name: 'is_banned') @Default(false) bool isBanned,

    /// Created at
    /// example: 2019-03-31T20:43:52+00:00
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// Is with ads
    /// example: false
    @JsonKey(name: 'is_with_ads') @Default(false) bool isWithAds,
  }) = _UserProfileModel;

  /// Generate Class from Map<String, Object?>
  factory UserProfileModel.fromJson(Map<String, Object?> json) =>
      _$UserProfileModelFromJson(json);
}

/// Torrents data model
@freezed
abstract class UserProfileTorrentsModel with _$UserProfileTorrentsModel {
  const factory UserProfileTorrentsModel({
    /// Passkey
    /// example: xBSmRDA95bJXPk3E
    /// passkey, отображается только собственный
    @JsonKey(name: 'passkey') String? passkey,

    /// Uploaded bytes
    /// example: 998234623
    /// Количество отданного, в байтах
    @JsonKey(name: 'uploaded') @Default(0) int uploaded,

    /// Downloaded bytes
    /// example: 2397162874432
    /// Количество скачанного, в байтах
    @JsonKey(name: 'downloaded') @Default(0) int downloaded,
  }) = _UserProfileTorrentsModel;

  /// Generate Class from Map<String, Object?>
  factory UserProfileTorrentsModel.fromJson(Map<String, Object?> json) =>
      _$UserProfileTorrentsModelFromJson(json);
}
