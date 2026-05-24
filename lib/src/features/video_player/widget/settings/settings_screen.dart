import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/settings/quality_selector.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/settings/shortcuts_list.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.platformType.isMobile) {
      return const _SettingsBottomSheet();
    }
    return const _SettingsDialog();
  }
}

class _SettingsDialog extends StatelessWidget {
  const _SettingsDialog();

  @override
  Widget build(BuildContext context) => AdaptiveDialog(
    title: const _Title(),
    content: const _SettingsLayout(),
    actions: [
      TextButton(
        child: const Text('Закрыть'),
        onPressed: () => _onClose(context),
      ),
    ],
  );

  void _onClose(BuildContext context) {
    final wm = PlayerEpisodeScope.settingsWMOf(
      context,
      listen: false,
    );
    return wm.closeSettings();
  }
}

class _SettingsBottomSheet extends StatelessWidget {
  const _SettingsBottomSheet();

  @override
  Widget build(BuildContext context) => AdaptiveSheet(
    title: const _Title(),
    builder: (context, scrollController) => _SettingsLayout(
      scrollController: scrollController,
    ),
  );
}

class _SettingsLayout extends StatelessWidget {
  final ScrollController? scrollController;

  const _SettingsLayout({this.scrollController});

  @override
  Widget build(BuildContext context) => TitleEpisodeStateSelector(
    selector: (state) => state.episodeOrNull,
    builder: (context, episode, child) {
      if (episode == null) {
        return const ProgressLayout();
      }

      return _SettingsContent(
        episode: episode,
        scrollController: scrollController,
      );
    },
  );
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) => const Text('Настройки');
}

class _SettingsContent extends StatelessWidget {
  final Episode episode;
  final ScrollController? scrollController;

  const _SettingsContent({
    required this.episode,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) => Flexible(
    child: ListView(
      physics: scrollController == null
          ? const NeverScrollableScrollPhysics()
          : null,
      controller: scrollController,
      padding: context.spacingH,
      shrinkWrap: scrollController == null,
      children: [
        QualitySelector(hls: episode.hls),
        const Divider(),
        const ShortcutsList(),
      ],
    ),
  );
}
