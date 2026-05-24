import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_release_state.freezed.dart';

/// {@template catalog_release_state}
/// State for catalog releases feature.
///
/// Represents different states of the catalog releases loading process:
/// - idle - Waiting for user action or data is ready
/// - progress - Loading releases data
/// - success - Releases loaded successfully
/// - error - An error occurred during loading (non-fatal, data may be available)
/// - fatalError - A critical error occurred (no data available)
/// {@endtemplate}
@freezed
sealed class CatalogReleaseState with _$CatalogReleaseState {
  const CatalogReleaseState._();

  /// Returns true if the state is idle (waiting for user action or data is ready)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed, but data may be available)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns true if the state is fatalError (critical error, no data available)
  bool get isFatal => maybeMap(orElse: () => false, fatalError: (_) => true);

  /// {@macro catalog_release_state}
  ///
  /// Waiting for user action or data is ready - initial state or after successful load
  ///
  /// [release] - The list of loaded releases
  /// [pagination] - The pagination information
  const factory CatalogReleaseState.idle({
    @Default(<AnimeReleaseModel>[]) List<AnimeReleaseModel> release,
    @Default(AnimeCommonPaginationModel.initial)
    AnimeCommonPaginationModel pagination,
  }) = _IdleCatalogReleaseState;

  /// {@macro catalog_release_state}
  ///
  /// Loading data - releases request is in progress
  ///
  /// [release] - The current list of releases (may be empty or contain previous data)
  /// [pagination] - The current pagination information
  const factory CatalogReleaseState.progress({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _ProgressCatalogReleaseState;

  /// {@macro catalog_release_state}
  ///
  /// Data loaded successfully - new releases are available
  ///
  /// [release] - The updated list of releases
  /// [pagination] - The updated pagination information
  const factory CatalogReleaseState.success({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _SuccessCatalogReleaseState;

  /// {@macro catalog_release_state}
  ///
  /// An error occurred - loading failed but previous data may be available
  ///
  /// [release] - The list of releases (may contain previous data)
  /// [pagination] - The pagination information
  const factory CatalogReleaseState.error({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _ErrorCatalogReleaseState;

  /// {@macro catalog_release_state}
  ///
  /// A critical error occurred - no data available, requires user action
  ///
  /// [release] - Empty list of releases
  /// [pagination] - Initial pagination information
  const factory CatalogReleaseState.fatalError({
    @Default(<AnimeReleaseModel>[]) List<AnimeReleaseModel> release,
    @Default(AnimeCommonPaginationModel.initial)
    AnimeCommonPaginationModel pagination,
  }) = _FatalErrorCatalogReleaseState;
}
