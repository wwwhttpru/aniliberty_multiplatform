import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_references_state.freezed.dart';

/// {@template catalog_references_state}
/// State for catalog references feature.
///
/// Represents different states of the catalog references loading process:
/// - idle - Waiting for user action
/// - progress - Loading references data
/// - success - References loaded successfully
/// - error - An error occurred during loading
/// {@endtemplate}
@freezed
sealed class CatalogReferencesState with _$CatalogReferencesState {
  const CatalogReferencesState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// {@macro catalog_references_state}
  ///
  /// Waiting for user action - initial state when no data is being loaded
  const factory CatalogReferencesState.idle() = _IdleCatalogReferencesState;

  /// {@macro catalog_references_state}
  ///
  /// Loading data - references request is in progress
  const factory CatalogReferencesState.progress() =
      _ProgressCatalogReferencesState;

  /// {@macro catalog_references_state}
  ///
  /// Data loaded successfully - references are available
  ///
  /// [references] - The catalog references model containing all filter options
  const factory CatalogReferencesState.success({
    required AnimeCatalogReferencesModel references,
  }) = _SuccessCatalogReferencesState;

  /// {@macro catalog_references_state}
  ///
  /// An error occurred - references loading failed
  const factory CatalogReferencesState.error() = _ErrorCatalogReferencesState;
}
