import 'package:aniliberty_multiplatform/src/datasource_v2/anime_franchise/anime_franchise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_franchises_model.freezed.dart';
part 'anime_franchises_model.g.dart';

@freezed
abstract class AnimeFranchisesModel with _$AnimeFranchisesModel {
  const factory AnimeFranchisesModel({
    /// Список франшиз
    @JsonKey(name: 'franchises') required List<AnimeFranchiseModel> franchises,
  }) = _AnimeFranchisesModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeFranchisesModel.fromJson(Map<String, Object?> json) =>
      _$AnimeFranchisesModelFromJson(json);
}
