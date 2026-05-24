import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/player_hls.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

/// Represents an episode of a title release.
///
/// An episode contains information about a single episode including its name,
/// number, unique identifier, HLS streaming data, skip timings for opening/ending,
/// and optional preview image.
@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    /// Episode name
    required String name,

    /// Episode number
    required double episode,

    /// Unique identifier of the episode
    required String uuid,

    /// HLS player streaming data with different quality options
    required PlayerHls hls,

    /// Opening skip timing (time range to skip)
    required Skips? opening,

    /// Ending skip timing (time range to skip)
    required Skips? ending,

    /// Link to the episode preview image
    required String? preview,
  }) = _Episode;
}

/// Represents a time range for skipping (e.g., opening or ending sequences).
///
/// The skip range is defined by start and stop times in seconds from the
/// beginning of the episode.
@freezed
abstract class Skips with _$Skips {
  const factory Skips({
    /// Start time in seconds from the beginning of the episode
    required int startSec,

    /// Stop time in seconds from the beginning of the episode
    required int stopSec,
  }) = _Skips;
}
