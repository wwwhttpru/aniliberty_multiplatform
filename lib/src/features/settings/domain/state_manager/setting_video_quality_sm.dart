import 'package:aniliberty_multiplatform/src/features/settings/domain/repository/settings_repository.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/state_manager/setting_value_sm.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/video_quality.dart';

class _SettingVideoQualityUseCase
    implements ISettingValueUseCase<VideoQuality> {
  final ISettingsRepository _repository;

  @override
  VideoQuality get defaultValue => VideoQuality.hd;

  _SettingVideoQualityUseCase({
    required this._repository,
  });

  @override
  Future<void> createOrUpdate(
    VideoQuality value,
  ) => _repository.writeVideoQuality(value);

  @override
  Future<VideoQuality> read() => _repository.readVideoQuality();
}

/// {@template setting_video_quality_sm}
/// State manager for video quality setting
/// {@endtemplate}
final class SettingVideoQualitySM extends SettingValueSM<VideoQuality> {
  /// {@macro setting_video_quality_sm}
  SettingVideoQualitySM({
    required ISettingsRepository repository,
  }) : super(useCase: _SettingVideoQualityUseCase(repository: repository));
}
