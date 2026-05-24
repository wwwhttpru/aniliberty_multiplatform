import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_franchise_release_model.freezed.dart';
part 'anime_franchise_release_model.g.dart';

/// Данные по релизам в франшизе
@freezed
abstract class AnimeFranchiseReleaseModel with _$AnimeFranchiseReleaseModel {
  const factory AnimeFranchiseReleaseModel({
    /// ID связки релиз — франшиза
    ///
    /// example: db1ebabd-b4b8-4391-85f3-79294515641a
    @JsonKey(name: 'id') required String id,

    /// Порядок сортировки
    ///
    /// example: 2
    @JsonKey(name: 'sort_order') required int sortOrder,

    /// Идентификатор релиза
    ///
    /// example: 9045
    @JsonKey(name: 'release_id') required int releaseId,

    /// Идентификатор франшизы
    ///
    /// example: 3f69ea9b-c202-4522-96b9-07a5de8aa963
    @JsonKey(name: 'franchise_id') required String franchiseId,

    /// Данные по релизу
    @JsonKey(name: 'release') required AnimeReleaseModel release,
  }) = _AnimeFranchiseReleaseModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeFranchiseReleaseModel.fromJson(Map<String, Object?> json) =>
      _$AnimeFranchiseReleaseModelFromJson(json);
}
