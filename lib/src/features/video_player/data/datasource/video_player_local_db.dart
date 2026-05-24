import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';

abstract interface class IVideoPlayerLocalDB {
  /// Read video quality from database
  Future<VideoQuality> readVideoQuality();
}

class VideoPlayerLocalDB implements IVideoPlayerLocalDB {
  /// Video quality state manager
  final SettingVideoQualitySM _qualitySM;

  /// Creates a new instance of [VideoPlayerLocalDB].
  ///
  /// [_qualitySM] - The video quality state manager.
  const VideoPlayerLocalDB({
    required this._qualitySM,
  });

  /// Read video quality from database
  @override
  Future<VideoQuality> readVideoQuality() async {
    final state = _qualitySM.state;
    return state.value;
  }
}
