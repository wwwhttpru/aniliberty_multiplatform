import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/episode.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/title_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'title_episode_state.freezed.dart';

/// State representing the loading and selection status of a title episode.
///
/// This state machine tracks the lifecycle of loading title release data
/// and selecting a specific episode. It provides convenient getters to check
/// the current state and access the loaded data when available.
@freezed
sealed class TitleEpisodeState with _$TitleEpisodeState {
  const TitleEpisodeState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if data is currently being loaded
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if data has been successfully loaded
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if an error occurred while loading data
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns the title release if available, null otherwise
  TitleRelease? get releaseOrNull => maybeMap(
    orElse: () => null,
    success: (value) => value.titleRelease,
  );

  /// Returns the selected episode if available, null otherwise
  Episode? get episodeOrNull => maybeMap(
    orElse: () => null,
    success: (value) => value.selectedEpisode,
  );

  /// Initial state - waiting for user action to load data
  const factory TitleEpisodeState.idle() = _IdleTitleEpisodeState;

  /// Loading state - data is being fetched from the network
  const factory TitleEpisodeState.progress() = _ProgressTitleEpisodeState;

  /// Success state - data has been loaded successfully
  const factory TitleEpisodeState.success({
    /// The loaded title release containing all episodes
    required TitleRelease titleRelease,

    /// The currently selected episode
    required Episode selectedEpisode,
  }) = _SuccessTitleEpisodeState;

  /// Error state - failed to load data
  const factory TitleEpisodeState.error() = _ErrorTitleEpisodeState;
}
