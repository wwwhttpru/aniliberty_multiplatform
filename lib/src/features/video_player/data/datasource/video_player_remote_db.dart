import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// Interface for remote data source that provides episode data for video player.
abstract interface class IVideoPlayerRemoteDB {
  /// Returns episode data for a release.
  ///
  /// [releaseEpisodeId] - The identifier of the episode.
  Future<AnimeReleaseEpisodeModel> getEpisodeById(String releaseEpisodeId);
}

/// Remote data source for fetching episode data in the video player.
///
/// This class handles network requests to retrieve episode information
/// from the Anilibria API.
///
/// For more information about the API, see: <https://anilibria.top/api/docs/v1#/>
@immutable
final class VideoPlayerRemoteDB implements IVideoPlayerRemoteDB {
  /// Network client for making API requests.
  final AppNetwork _appNetwork;

  /// Creates a new instance of [VideoPlayerRemoteDB].
  ///
  /// [_appNetwork] - The network client used for API requests.
  const VideoPlayerRemoteDB({
    required this._appNetwork,
  });

  /// Fetches episode data by its identifier from the remote API.
  ///
  /// Makes a GET request to `/anime/releases/episodes/{releaseEpisodeId}`
  /// and parses the response into an [AnimeReleaseEpisodeModel].
  ///
  /// Throws an [ArgumentError] if the response data is null.
  @override
  Future<AnimeReleaseEpisodeModel> getEpisodeById(
    String releaseEpisodeId,
  ) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/releases/episodes/$releaseEpisodeId',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeReleaseEpisodeModel.fromJson(data);
  }
}
