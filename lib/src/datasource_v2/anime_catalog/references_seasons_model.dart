import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_seasons_model.freezed.dart';
part 'references_seasons_model.g.dart';

@freezed
abstract class ReferencesSeasonsModel with _$ReferencesSeasonsModel {
  const factory ReferencesSeasonsModel({
    /// Список сезонов релизов
    @JsonKey(name: 'seasons') required List<ReferencesSeasonModel> seasons,
  }) = _ReferencesSeasonsModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesSeasonsModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesSeasonsModelFromJson(json);
}

@freezed
abstract class ReferencesSeasonModel with _$ReferencesSeasonModel {
  const factory ReferencesSeasonModel({
    /// Значение сезона
    ///
    /// example: winter
    @JsonKey(name: 'value') required String value,

    /// Название сезона
    ///
    /// example: Зима
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesSeasonModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesSeasonModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesSeasonModelFromJson(json);
}
