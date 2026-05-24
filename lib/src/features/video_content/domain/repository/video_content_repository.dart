import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// {@template i_video_content_repository}
/// Repository for video content functionality.
/// {@endtemplate}
abstract interface class IVideoContentRepository {
  /// Reads video content items from network.
  ///
  /// Returns a list of the latest video content items up to the specified limit.
  ///
  /// [limit] - The maximum number of video content items to return
  ///
  /// Returns [MediaVideoContentsModel] containing the video content items
  Future<MediaVideoContentsModel> readVideoContentsFromNetwork({
    required int limit,
  });
}
