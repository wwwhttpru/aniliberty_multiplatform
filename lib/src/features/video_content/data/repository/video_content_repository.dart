import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/data/datasource/video_content_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template video_content_repository}
/// Repository for video content functionality.
///
/// Provides access to video content data from remote sources.
/// {@endtemplate}
@immutable
class VideoContentRepository implements IVideoContentRepository {
  /// {@macro i_video_content_remote_db}
  final IVideoContentRemoteDB _remoteDB;

  /// {@macro video_content_repository}
  ///
  /// Creates a new instance of [VideoContentRepository].
  ///
  /// [_remoteDB] - The remote data source for video content operations
  const VideoContentRepository({
    required this._remoteDB,
  });

  @override
  Future<MediaVideoContentsModel> readVideoContentsFromNetwork({
    required int limit,
  }) => _remoteDB.readVideoContents(limit: limit);
}
