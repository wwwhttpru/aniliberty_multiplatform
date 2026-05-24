import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';

/// Widget that provides video player episode scope to its descendants.
///
/// This widget manages the lifecycle of episode-related state managers and
/// provides access to them through static methods. It automatically handles
/// loading states and provides the episode container scope when ready.
class PlayerEpisodeScope extends StatelessWidget {
  final EpisodeContainerSM episodeContainerSM;
  final String episodeId;
  final Widget child;

  const PlayerEpisodeScope({
    required this.episodeContainerSM,
    required this.episodeId,
    required this.child,
    super.key,
  });

  /// Retrieves the episode container output scope from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes in the scope (defaults to true)
  ///
  /// Returns the [EpisodeContainerOutputScope] if found, throws an error otherwise.
  static EpisodeContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = _PlayerEpisodeInheritedWidget.of(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(container, 'IVideoPlayerContainerScope');
  }

  /// Retrieves the title episode state manager from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static TitleEpisodeSM titleEpisodeSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).titleEpisodeSM;

  /// Retrieves the video player controller manager from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static VideoPlayerControllerManager controllerSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).controllerSM;

  /// Retrieves the video player info state manager from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static VideoPlayerInfoSM infoSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).infoSM;

  /// Retrieves the video quality state manager from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static VideoQualitySM videoQualitySMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoQualitySM;

  /// Retrieves the video player control widget model from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static IVideoPlayerControlWM controlWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).controlWM;

  /// Retrieves the episodes widget model from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static IEpisodesWM episodesWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).episodesWM;

  /// Retrieves the settings widget model from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static ISettingsWM settingsWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).settingsWM;

  /// Retrieves the video shortcuts from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static IVideoShortcuts shortcutsOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).shortcuts;

  /// Retrieves the full screen service from the widget tree.
  ///
  /// [context] - The build context to search for the scope
  /// [listen] - Whether to listen to changes (defaults to true)
  static IFullScreenService fullScreenServiceOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).fullScreenService;

  @override
  Widget build(BuildContext context) => EpisodeContainerStateBuilder(
    episodeContainerSM: episodeContainerSM,
    episodeId: episodeId,
    scope: (context, scope) => _PlayerEpisodeInheritedWidget(
      container: scope,
      child: child,
    ),
    noScope: (context) => const ProgressLayout(),
  );
}

class _PlayerEpisodeInheritedWidget extends InheritedWidget {
  final EpisodeContainerOutputScope container;

  const _PlayerEpisodeInheritedWidget({
    required this.container,
    required super.child,
  });

  static EpisodeContainerOutputScope? of(
    BuildContext context, {
    bool listen = true,
  }) {
    _PlayerEpisodeInheritedWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<_PlayerEpisodeInheritedWidget>();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_PlayerEpisodeInheritedWidget>();
    }

    return widget?.container;
  }

  @override
  bool updateShouldNotify(_PlayerEpisodeInheritedWidget oldWidget) =>
      !identical(container, oldWidget.container);
}
