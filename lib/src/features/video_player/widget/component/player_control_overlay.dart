import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state_manager/video_player_sm.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/episode_name_tile.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/episodes_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/exit_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/full_screen_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/hide_control_overlay.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/next_episode_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/play_pause_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/seek_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/skip_button.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/title_name_tile.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/video_duration.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/component/video_progress_slider.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/settings/settings.dart';
import 'package:flutter/material.dart';

class PlayerControlOverlay extends StatelessWidget {
  final Widget child;

  const PlayerControlOverlay({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => HideControlOverlay(
    child: child,
    additionalControls: [
      Positioned(
        child: const Row(
          spacing: 4,
          children: [
            SkipButton(),
            NextEpisodeButton(),
          ],
        ),
        right: _safeRightPadding(context),
        // 48 - slider padding
        // 48 - slider height
        // * - bottom padding
        // 8 - padding between slider and skip button
        bottom: 48 + 48 + _safeBottomPadding(context) + 8,
      ),
      const _ProgressIndicator(),
    ],
    controls: SafeArea(
      minimum: context.spacingAll,
      child: const Stack(
        children: [
          _CloseButton(),
          _BottomLayout(),
          _ProgressSlider(),
        ],
      ),
    ),
  );

  /// Calculate the safe right padding by taking
  /// into account the safe area and the resolver padding.
  double _safeRightPadding(BuildContext context) {
    final padding = context.spacingHOrSa;
    return padding.right;
  }

  /// Calculate the safe bottom padding by taking
  /// into account the safe area and the resolver padding.
  double _safeBottomPadding(BuildContext context) {
    final padding = context.spacingVOrSa;
    return padding.bottom;
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) => Align(
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
  );
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) => Center(
    child: VideoPlayerInfoStateSelector<bool>(
      selector: (state) => state.isBuffering,
      builder: (context, isBuffering, _) => isBuffering
          ? const CircularProgressIndicator()
          : const SizedBox.shrink(),
    ),
  );
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton();

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateBuilder(
    buildWhen: (prev, next) =>
        prev.isPlaying != next.isPlaying ||
        prev.isBuffering != next.isBuffering,
    builder: (context, state, _) => PlayPauseButton(
      onTap: () => _onTap(context),
      state: _onState(state),
    ),
  );

  void _onTap(BuildContext context) {
    final control = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );

    return control.playOrPause().ignore();
  }

  PlayPauseButtonState _onState(VideoPlayerState state) {
    if (state.isBuffering) {
      return PlayPauseButtonState.progress;
    }

    return state.isPlaying
        ? PlayPauseButtonState.pause
        : PlayPauseButtonState.play;
  }
}

class _SeekNext extends StatelessWidget {
  const _SeekNext();

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateSelector(
    selector: (state) => state.isBuffering,
    builder: (context, isProgress, _) => SeekButton(
      onTap: () => _onTap(context),
      isProgress: isProgress,
      direction: SeekButtonDirection.next,
    ),
  );

  void _onTap(BuildContext context) {
    final control = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );
    return control.seekNext().ignore();
  }
}

class _SeekPrev extends StatelessWidget {
  const _SeekPrev();

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateSelector(
    selector: (state) => state.isBuffering,
    builder: (context, isProgress, _) => SeekButton(
      onTap: () => _onTap(context),
      isProgress: isProgress,
      direction: SeekButtonDirection.prev,
    ),
  );

  void _onTap(BuildContext context) {
    final control = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );
    return control.seekPrev().ignore();
  }
}

class _BottomLayout extends StatelessWidget {
  const _BottomLayout();

  @override
  Widget build(BuildContext context) => const Align(
    alignment: AlignmentDirectional.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EpisodesButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SeekPrev(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: _PlayPauseButton(),
            ),
            _SeekNext(),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [SettingsButton(), FullScreenButton()],
        ),
      ],
    ),
  );
}

class _EpisodeName extends StatelessWidget {
  const _EpisodeName();

  @override
  Widget build(BuildContext context) => TitleEpisodeStateSelector(
    selector: (state) => state.episodeOrNull,
    builder: (context, state, _) {
      if (state == null) {
        return const SizedBox.shrink();
      }

      return EpisodeNameTile(episode: state);
    },
  );
}

class _VideoPosition extends StatelessWidget {
  const _VideoPosition();

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateBuilder(
    buildWhen: (prev, next) => prev.position != next.position,
    builder: (context, state, _) => VideoDuration(duration: state.position),
  );
}

class _VideoDuration extends StatelessWidget {
  const _VideoDuration();

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateBuilder(
    buildWhen: (prev, next) => prev.duration != next.duration,
    builder: (context, state, _) => VideoDuration(duration: state.duration),
  );
}

class _ProgressSlider extends StatelessWidget {
  const _ProgressSlider();

  @override
  Widget build(BuildContext context) => const Positioned(
    left: 0,
    right: 0,
    bottom: 48,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        _EpisodeName(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _VideoPosition(),
            Expanded(child: VideoProgressSlider()),
            _VideoDuration(),
          ],
        ),
      ],
    ),
  );
}
