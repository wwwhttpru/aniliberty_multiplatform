import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_search_state.freezed.dart';

/// {@template anime_search_state}
/// State for anime search feature.
///
/// Represents different states of the search process:
/// - idle - Waiting for user action
/// - progress - Loading search results
/// - success - Search results loaded successfully
/// - error - An error occurred during search
/// {@endtemplate}
@freezed
sealed class AnimeSearchState with _$AnimeSearchState {
  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// {@macro anime_search_state}
  ///
  /// Waiting for user action - initial state when no search is performed
  const factory AnimeSearchState.idle() = IdleAnimeSearchState;

  /// {@macro anime_search_state}
  ///
  /// Loading data - search request is in progress
  const factory AnimeSearchState.progress() = ProgressAnimeSearchState;

  /// {@macro anime_search_state}
  ///
  /// Data loaded successfully - search results are available
  ///
  /// [animeSearch] - The search results model containing found releases
  const factory AnimeSearchState.success({
    required AnimeSearchModel animeSearch,
  }) = SuccessAnimeSearchState;

  /// {@macro anime_search_state}
  ///
  /// An error occurred - search request failed
  const factory AnimeSearchState.error() = ErrorAnimeSearchState;

  const AnimeSearchState._();
}
