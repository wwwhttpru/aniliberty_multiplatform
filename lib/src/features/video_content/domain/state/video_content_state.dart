import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_content_state.freezed.dart';

/// {@template video_content_state}
/// State for video content feature.
///
/// Represents different states of the video content loading process:
/// - idle - Waiting for user action
/// - progress - Loading video content
/// - success - Video content loaded successfully
/// - error - An error occurred during loading
/// {@endtemplate}
@freezed
sealed class VideoContentState with _$VideoContentState {
  const VideoContentState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// {@macro video_content_state}
  ///
  /// Waiting for user action - initial state when no data is being loaded
  const factory VideoContentState.idle() = _IdleVideoContentState;

  /// {@macro video_content_state}
  ///
  /// Loading data - video content request is in progress
  const factory VideoContentState.progress() = _ProgressVideoContentState;

  /// {@macro video_content_state}
  ///
  /// Data loaded successfully - video content is available
  ///
  /// [mediaVideoContents] - The video content model containing video items
  const factory VideoContentState.success({
    required MediaVideoContentsModel mediaVideoContents,
  }) = _SuccessVideoContentState;

  /// {@macro video_content_state}
  ///
  /// An error occurred - video content loading failed
  const factory VideoContentState.error() = _ErrorVideoContentState;
}
