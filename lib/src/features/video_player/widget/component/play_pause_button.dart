import 'package:flutter/material.dart';

enum PlayPauseButtonState {
  progress,
  play,
  pause
  ;

  double get value => switch (this) {
    PlayPauseButtonState.progress => 0.0,
    PlayPauseButtonState.pause => 1.0,
    PlayPauseButtonState.play => 0.0,
  };

  bool get isProgress => this == PlayPauseButtonState.progress;
}

class PlayPauseButton extends StatefulWidget {
  final PlayPauseButtonState state;
  final VoidCallback onTap;

  const PlayPauseButton({required this.state, required this.onTap, super.key});

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: widget.state.value,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void didUpdateWidget(covariant PlayPauseButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      _syncStateWithController();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: widget.state.isProgress ? null : widget.onTap,
      icon: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: controller),
      color: colorScheme.onSurface,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.38),
      iconSize: 32,
    );
  }

  Future<void> _syncStateWithController() async {
    if (controller.value == widget.state.value) {
      return;
    }

    try {
      switch (widget.state) {
        case PlayPauseButtonState.play:
          await controller.reverse().orCancel;
        case PlayPauseButtonState.progress:
        case PlayPauseButtonState.pause:
          await controller.forward().orCancel;
      }
    } on TickerCanceled {
      // ignore
    }
  }
}
