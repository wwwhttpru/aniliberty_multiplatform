import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// {@template i_video_content_remote_db}
/// Interface for remote data source that provides video content functionality.
/// {@endtemplate}
abstract interface class IVideoContentRemoteDB {
  /// Reads a list of video content items.
  ///
  /// Returns a list of video content items up to the specified limit.
  ///
  /// [limit] - The maximum number of video content items to return
  ///
  /// Returns [MediaVideoContentsModel] containing the video content items
  Future<MediaVideoContentsModel> readVideoContents({required int limit});
}

/// {@macro i_video_content_remote_db}
///
/// Implementation of [IVideoContentRemoteDB] that uses the Anilibria API.
///
/// More information about the API: <https://anilibria.top/api/docs/v1#/>
@immutable
class VideoContentRemoteDB implements IVideoContentRemoteDB {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_video_content_remote_db}
  ///
  /// Creates a new instance of [VideoContentRemoteDB].
  ///
  /// [_appNetwork] - The network client for API requests
  const VideoContentRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<MediaVideoContentsModel> readVideoContents({
    required int limit,
  }) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/media/videos',
      queryParameters: {'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return MediaVideoContentsModel.fromJson({'media_video_contents': data});
  }
}
