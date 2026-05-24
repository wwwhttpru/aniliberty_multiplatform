import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_production_statuses_model.freezed.dart';
part 'references_production_statuses_model.g.dart';

@freezed
abstract class ReferencesProductionStatusesModel
    with _$ReferencesProductionStatusesModel {
  const factory ReferencesProductionStatusesModel({
    /// Список статусов
    @JsonKey(name: 'production_statuses')
    required List<ReferencesProductionStatusModel> productionStatuses,
  }) = _ReferencesProductionStatusesModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesProductionStatusesModel.fromJson(
    Map<String, Object?> json,
  ) => _$ReferencesProductionStatusesModelFromJson(json);
}

@freezed
abstract class ReferencesProductionStatusModel
    with _$ReferencesProductionStatusModel {
  const factory ReferencesProductionStatusModel({
    /// Значение статуса
    ///
    /// example: IS_IN_PRODUCTION
    @JsonKey(name: 'value') required String value,

    /// Описание статуса
    ///
    /// example: Сейчас в озвучке
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesProductionStatusModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesProductionStatusModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesProductionStatusModelFromJson(json);
}
