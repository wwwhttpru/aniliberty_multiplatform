import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_types_model.freezed.dart';
part 'references_types_model.g.dart';

@freezed
abstract class ReferencesTypesModel with _$ReferencesTypesModel {
  const factory ReferencesTypesModel({
    /// Список типов релизов
    @JsonKey(name: 'types') required List<ReferencesTypeModel> types,
  }) = _ReferencesTypesModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesTypesModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesTypesModelFromJson(json);
}

@freezed
abstract class ReferencesTypeModel with _$ReferencesTypeModel {
  const factory ReferencesTypeModel({
    /// Значение типа
    ///
    /// example: TV
    @JsonKey(name: 'value') required String value,

    /// Название типа
    ///
    /// example: ТВ
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesTypeModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesTypeModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesTypeModelFromJson(json);
}
