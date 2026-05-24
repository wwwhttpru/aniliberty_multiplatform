import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/title_release.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/video_quality.dart';

/// Repository interface for fetching video player data.
///
/// Provides methods to retrieve title release information including
/// episode data, title metadata, and streaming URLs.
abstract interface class IVideoPlayerRepository {
  /// Retrieves a [TitleRelease] by episode identifier from the network.
  ///
  /// Fetches the complete title release data including all episodes,
  /// title names, and episode metadata for the specified episode.
  ///
  /// [releaseEpisodeId] - The unique identifier of the release episode
  ///
  /// Returns a [Future] that completes with the [TitleRelease] containing
  /// the title information and all available episodes.
  ///
  /// Throws an exception if the episode is not found or network request fails.
  Future<TitleRelease> readTitleReleaseByIdFromNetwork(
    String releaseEpisodeId,
  );

  /// Reads the selected video quality from storage.
  ///
  /// Retrieves the saved video quality preference from local storage.
  ///
  /// Returns a [Future] that completes with the [VideoQuality] that was
  /// previously selected by the user.
  ///
  /// Throws an exception if the quality cannot be read from storage.
  Future<VideoQuality> readVideoQuality();
}
