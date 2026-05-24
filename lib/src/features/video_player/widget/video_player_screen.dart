import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/episodes/episodes.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/shortcuts/video_player_shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: TitleEpisodeStateBuilder(
      builder: (context, episode, _) => VideoPlayerControllerBuilder(
        builder: (context, video, _) {
          Widget child = const _ProgressLayout();

          if (episode.isError || video.isError) {
            child = const _ErrorLayout();
          }

          if (episode.isProgress || video.isProgress) {
            child = const _ProgressLayout();
          }

          final controller = video.maybeController;
          if (controller != null) {
            child = _SuccessLayout(controller);
          }

          if (episode.isSuccess && video.isEmpty) {
            child = const _EmptyLayout();
          }

          return AnimateSwitchLayout(child: child);
        },
      ),
    ),
    drawer: const EpisodesDrawer(),
    drawerEnableOpenDragGesture: false,
  );
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout() : super(key: const Key('progress'));

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: context.spacingAll,
    child: const Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: ExitButton(),
        ),
        Center(child: ProgressLayout()),
      ],
    ),
  );
}

// TODO(wwwhttpru): add empty layout
class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout() : super(key: const Key('empty'));

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: context.spacingAll,
    child: Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Row(
            children: [
              const ExitButton(),
              Expanded(
                child: TitleEpisodeStateSelector(
                  selector: (value) => value.releaseOrNull?.name,
                  builder: (context, state, _) {
                    if (state == null) {
                      return const SizedBox.shrink();
                    }

                    return TitleNameTile(name: state);
                  },
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Empty?')),
              TitleEpisodeStateSelector(
                selector: (state) => state.episodeOrNull?.name,
                builder: (context, state, _) => switch (state) {
                  String() => Text(state),
                  null => const SizedBox.shrink(),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// TODO(wwwhttpru): add error layout
class _ErrorLayout extends StatelessWidget {
  const _ErrorLayout() : super(key: const Key('error'));

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: context.spacingAll,
    child: Stack(
      children: [
        const Align(
          alignment: AlignmentDirectional.topStart,
          child: ExitButton(),
        ),
        Center(child: ErrorLayout(onTap: () {})),
      ],
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final VideoPlayerController controller;

  _SuccessLayout(this.controller) : super(key: ObjectKey(controller));

  @override
  Widget build(BuildContext context) => PlayerControlOverlay(
    child: VideoPlayerShortcuts(
      child: AdaptedVideoPlayer(
        controller: controller,
      ),
    ),
  );
}
