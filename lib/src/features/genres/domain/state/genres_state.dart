import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'genres_state.freezed.dart';

/// UI state for the genres list screen.
///
/// Use [isIdle], [isProgress], [isSuccess], [isError] to branch in the UI.
/// The success variant holds the loaded genre list.
@freezed
sealed class GenresState with _$GenresState {
  const GenresState._();

  /// True when the screen is waiting for user action or after a flow has finished.
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// True while genres are being loaded.
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// True when the last load succeeded; the success variant carries the genre data.
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// True when the last load failed.
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Initial or post-flow state; no load in progress.
  const factory GenresState.idle() = _IdleGenresState;

  /// Genres are currently loading.
  const factory GenresState.progress() = _ProgressGenresState;

  /// Load succeeded; [animeGenres] contains the genre list.
  const factory GenresState.success({
    required AnimeGenresModel animeGenres,
  }) = _SuccessGenresState;

  /// Load failed; no genre data available.
  const factory GenresState.error() = _ErrorGenresState;
}
