import 'package:aniliberty_multiplatform/src/features/video_player/data/convert/player_converter.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/data/datasource/video_player_local_db.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/data/datasource/video_player_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:meta/meta.dart';

/// Repository for video player data operations.
///
/// This repository acts as a bridge between the data layer and domain layer,
/// coordinating data fetching from remote sources and converting API models
/// to domain models.
@immutable
final class VideoPlayerRepository implements IVideoPlayerRepository {
  /// Remote data source for fetching episode data.
  final IVideoPlayerRemoteDB _remoteDB;

  /// Local data source for storing video player data.
  final IVideoPlayerLocalDB _localDB;

  /// Converter for transforming API models to domain models.
  final PlayerConverter _converter;

  /// Creates a new instance of [VideoPlayerRepository].
  ///
  /// [_remoteDB] - The remote data source for fetching episode data.
  /// [_localDB] - The local data source for storing video player data.
  /// [_converter] - The converter for transforming data models.
  const VideoPlayerRepository({
    required this._remoteDB,
    required this._localDB,
    required this._converter,
  });

  /// Fetches a title release by episode ID from the network.
  ///
  /// Retrieves episode data from the remote data source, extracts the release
  /// information, and converts it to a domain model.
  ///
  /// [releaseEpisodeId] - The identifier of the episode.
  /// Returns a [TitleRelease] domain model containing the release information.
  /// Throws an [Exception] if the release is not found in the episode data.
  @override
  Future<TitleRelease> readTitleReleaseByIdFromNetwork(
    String releaseEpisodeId,
  ) async {
    // Fetch episode data from the network
    final episodeModel = await _remoteDB.getEpisodeById(releaseEpisodeId);
    final release = episodeModel.release;

    if (release == null) {
      throw Exception('Release not found');
    }

    // Convert API model to domain model
    final titleRelease = _converter.releaseFromAnimeRelease(release);
    return titleRelease;
  }

  /// Reads the selected video quality from storage.
  ///
  /// Retrieves the saved video quality preference from local storage.
  /// Currently returns a default quality (HD) as a placeholder.
  ///
  /// Returns a [Future] that completes with the [VideoQuality] that was
  /// previously selected by the user.
  ///
  /// Throws an exception if the quality cannot be read from storage.
  @override
  Future<VideoQuality> readVideoQuality() => _localDB.readVideoQuality();
}
