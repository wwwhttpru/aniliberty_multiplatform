import 'package:aniliberty_multiplatform/src/features/catalog/domain/entity/catalog_filter_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_filter_state.freezed.dart';

/// {@template catalog_filter_state}
/// State for catalog filter feature.
///
/// Represents different states of the catalog filter:
/// - idle - Waiting for user action, filter can be modified
/// - progress - Filter is being updated
/// - submitted - Filter form has been submitted
/// {@endtemplate}
@freezed
sealed class CatalogFilterState with _$CatalogFilterState {
  const CatalogFilterState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is submitted (form submitted)
  bool get isSubmitted => maybeMap(orElse: () => false, submitted: (_) => true);

  /// {@macro catalog_filter_state}
  ///
  /// Waiting for user action - filter can be modified
  ///
  /// [filter] - The current filter entity
  const factory CatalogFilterState.idle({
    required CatalogFilterEntity filter,
  }) = _IdleCatalogFilterState;

  /// {@macro catalog_filter_state}
  ///
  /// Loading data - filter is being updated
  ///
  /// [filter] - The current filter entity
  const factory CatalogFilterState.progress({
    required CatalogFilterEntity filter,
  }) = _ProgressCatalogFilterState;

  /// {@macro catalog_filter_state}
  ///
  /// Form submitted - filter has been applied
  ///
  /// [filter] - The submitted filter entity
  const factory CatalogFilterState.submitted({
    required CatalogFilterEntity filter,
  }) = _SubmittedCatalogFilterState;
}
