import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_sorting_model.freezed.dart';
part 'references_sorting_model.g.dart';

@freezed
abstract class ReferencesSortingModel with _$ReferencesSortingModel {
  const factory ReferencesSortingModel({
    /// Список типов сортировок
    @JsonKey(name: 'sorting')
    required List<ReferencesSortingValueModel> sorting,
  }) = _ReferencesSortingModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesSortingModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesSortingModelFromJson(json);
}

@freezed
abstract class ReferencesSortingValueModel with _$ReferencesSortingValueModel {
  const factory ReferencesSortingValueModel({
    /// Значение типа
    ///
    /// example: RATING_ASC
    @JsonKey(name: 'value') required String value,

    /// Название типа
    ///
    /// example: Самый низкий рейтинг
    @JsonKey(name: 'label') required String label,

    /// Описание типа
    ///
    /// example: Сначала отобразятся самые непопулярные релизы
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesSortingValueModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesSortingValueModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesSortingValueModelFromJson(json);
}
