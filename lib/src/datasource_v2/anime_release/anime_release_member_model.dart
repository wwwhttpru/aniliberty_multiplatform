// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_member_model.freezed.dart';
part 'anime_release_member_model.g.dart';

@freezed
abstract class AnimeReleaseMemberModel with _$AnimeReleaseMemberModel {
  const factory AnimeReleaseMemberModel({
    /// Идентификатор участника
    ///
    /// example: uuid...
    @JsonKey(name: 'id') required String id,

    /// Связанный с участником релиза пользователь. Может быть null
    @JsonKey(name: 'user') MemberUserModel? user,

    /// Роль
    @JsonKey(name: 'role') required MemberRoleModel role,

    /// example: Zvukar
    @JsonKey(name: 'nickname') required String nickname,
  }) = _AnimeReleaseMemberModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseMemberModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseMemberModelFromJson(json);
}

@freezed
abstract class MemberUserModel with _$MemberUserModel {
  const factory MemberUserModel({
    /// example: 2346
    @JsonKey(name: 'id') required int id,

    /// Аватар
    @JsonKey(name: 'avatar') required PosterPreviewModel avatar,

    /// example: Animeshnik488
    @JsonKey(name: 'nickname') String? nickname,
  }) = _MemberUserModel;

  /// Generate Class from Map<String, Object?>
  factory MemberUserModel.fromJson(Map<String, Object?> json) =>
      _$MemberUserModelFromJson(json);
}

@freezed
abstract class MemberRoleModel with _$MemberRoleModel {
  const factory MemberRoleModel({
    /// Значение
    @JsonKey(name: 'value', unknownEnumValue: MemberRole.unknown)
    required MemberRole value,

    /// example: Озвучка
    @JsonKey(name: 'description') required String description,
  }) = _MemberRoleModel;

  /// Generate Class from Map<String, Object?>
  factory MemberRoleModel.fromJson(Map<String, Object?> json) =>
      _$MemberRoleModelFromJson(json);
}

enum MemberRole {
  poster,
  timing,
  voicing,
  editing,
  decorating,
  translating,
  unknown,
}
