import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_publish_statuses_model.freezed.dart';
part 'references_publish_statuses_model.g.dart';

@freezed
abstract class ReferencesPublishStatusesModel
    with _$ReferencesPublishStatusesModel {
  const factory ReferencesPublishStatusesModel({
    /// Список статусов
    @JsonKey(name: 'publish_statuses')
    required List<ReferencesPublishStatusModel> publishStatuses,
  }) = _ReferencesPublishStatusesModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesPublishStatusesModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesPublishStatusesModelFromJson(json);
}

@freezed
abstract class ReferencesPublishStatusModel
    with _$ReferencesPublishStatusModel {
  const factory ReferencesPublishStatusModel({
    /// Значение статуса
    ///
    /// example: IS_ONGOING
    @JsonKey(name: 'value') required String value,

    /// Описание статуса
    ///
    /// example: Онгоинг
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesPublishStatusModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesPublishStatusModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesPublishStatusModelFromJson(json);
}
