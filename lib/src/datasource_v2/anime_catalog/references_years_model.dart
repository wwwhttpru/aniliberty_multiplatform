import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_years_model.freezed.dart';
part 'references_years_model.g.dart';

@freezed
abstract class ReferencesYearsModel with _$ReferencesYearsModel {
  const factory ReferencesYearsModel({
    /// Список годов
    @JsonKey(name: 'years') required List<int> years,
  }) = _ReferencesYearsModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesYearsModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesYearsModelFromJson(json);
}
