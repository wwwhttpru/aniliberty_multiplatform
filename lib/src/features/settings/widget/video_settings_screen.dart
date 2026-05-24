import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/common/list_radio_setting.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_video_quality_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/scope/settings_scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoSettingsScreen extends StatelessWidget {
  const VideoSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Видео настройки'),
    ),
    body: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: context.spacingHOrSa,
          sliver: SliverToBoxAdapter(
            child: SettingVideoQualityStateSelector(
              selector: (state) => state.value,
              builder: (context, state, child) => ListRadioSetting(
                title: 'Качество видео',
                icon: Icons.high_quality_outlined,
                items: VideoQuality.values,
                selected: state,
                onChanged: (value) => _onQualityChanged(context, value),
                itemLabel: (value) => switch (value) {
                  VideoQuality.fhd => '1080p',
                  VideoQuality.hd => '720p',
                  VideoQuality.sd => '480p',
                },
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: context.spacingAllOrSa.copyWith(top: 0),
          sliver: const SliverToBoxAdapter(),
        ),
      ],
    ),
  );

  void _onQualityChanged(BuildContext context, VideoQuality value) {
    final wm = SettingsScope.videoSettingsWMOf(
      context,
      listen: false,
    );
    return wm.setVideoQuality(value);
  }
}
