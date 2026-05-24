import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_releases_state.freezed.dart';

/// UI state for the genre releases screen (paginated list of releases).
///
/// Holds the current [release] list and [pagination] across all variants.
/// Use [isIdle], [isProgress], [isSuccess], [isError] to branch in the UI.
@freezed
sealed class GenreReleasesState with _$GenreReleasesState {
  const GenreReleasesState._();

  /// True when the screen is waiting for user action or after a flow has finished.
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// True while the next page is being loaded.
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// True when the last load succeeded.
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// True when the last load failed (previous data is still in [release]).
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Initial or post-flow state; no load in progress.
  const factory GenreReleasesState.idle({
    @Default(<AnimeReleaseModel>[]) List<AnimeReleaseModel> release,
    @Default(AnimeCommonPaginationModel.initial)
    AnimeCommonPaginationModel pagination,
  }) = _IdleGenreReleasesState;

  /// A page is currently loading; [release] and [pagination] reflect previous data.
  const factory GenreReleasesState.progress({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _ProgressGenreReleasesState;

  /// The last load succeeded; [release] and [pagination] are updated.
  const factory GenreReleasesState.success({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _SuccessGenreReleasesState;

  /// The last load failed; [release] and [pagination] keep the previous values.
  const factory GenreReleasesState.error({
    required List<AnimeReleaseModel> release,
    required AnimeCommonPaginationModel pagination,
  }) = _ErrorGenreReleasesState;
}
