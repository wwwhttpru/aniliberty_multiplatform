import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:meta/meta.dart';

/// {@template video_settings_wm}
/// Widget model for the video settings screen
/// {@endtemplate}
abstract interface class IVideoSettingsWM {
  /// Set video quality
  void setVideoQuality(VideoQuality quality);
}

/// {@macro video_settings_wm}
@immutable
class VideoSettingsWM implements IVideoSettingsWM {
  /// {@macro setting_video_quality_sm}
  final SettingVideoQualitySM _videoQualitySM;

  /// {@macro video_settings_wm}
  const VideoSettingsWM({
    required this._videoQualitySM,
  });

  @override
  void setVideoQuality(VideoQuality quality) {
    if (_videoQualitySM.state.isProgress) {
      return;
    }

    _videoQualitySM.createOrUpdate(quality);
  }
}
