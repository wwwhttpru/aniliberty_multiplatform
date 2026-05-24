import 'package:aniliberty_multiplatform/src/features/video_player/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class EpisodeContainerStateBuilder extends StatelessWidget {
  final EpisodeContainerSM episodeContainerSM;
  final String episodeId;
  final Widget Function(
    BuildContext context,
    EpisodeContainerOutputScope scope,
  )
  scope;
  final Widget Function(BuildContext context) noScope;

  const EpisodeContainerStateBuilder({
    required this.episodeContainerSM,
    required this.episodeId,
    required this.scope,
    required this.noScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<EpisodeContainerState>(
    stateReadable: episodeContainerSM,
    // TODO(wwwhttpru): Need sync scope with page ui animation
    // buildWhen: (prev, next) {
    //   final prevValue = prev[episodeId];
    //   final nextValue = next[episodeId];

    //   if (prevValue == null && nextValue != null) {
    //     return true;
    //   }

    //   if (prevValue != null && nextValue != null) {
    //     return prevValue != nextValue;
    //   }

    //   return false;
    // },
    builder: (context, state, _) => switch (state[episodeId]) {
      final EpisodeContainerOutputScope value => scope(context, value),
      null => noScope(context),
    },
  );
}
