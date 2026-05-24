import 'dart:async';
import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class HideControlOverlay extends StatefulWidget {
  /// Controls to display.
  final Widget controls;

  /// Additional controls to display.
  final List<Widget> additionalControls;

  /// Child widget to display.
  final Widget child;

  const HideControlOverlay({
    required this.controls,
    required this.additionalControls,
    required this.child,
    super.key,
  });

  @override
  State<HideControlOverlay> createState() => _HideControlOverlayState();
}

class _HideControlOverlayState extends State<HideControlOverlay> {
  /// Delay to hide controls.
  Duration get _hideDelay => context.readPlatformType.isMobile
      ? const Duration(seconds: 2)
      : const Duration(seconds: 3);

  /// Notifier to control the visibility of the controls.
  late final ValueNotifier<bool> _visible;

  /// Stream to listen to the info state of the video.
  late VideoPlayerInfoSM _infoSM;

  /// Stream to listen to the playing state of the video.
  late StreamSubscription<bool> _isPlayingSubscription;

  /// Current playing state of the video.
  late bool _isPlaying;

  /// Current route of the video player.
  late bool _isCurrentRoute;

  /// Timer to hide controls after a delay.
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _visible = ValueNotifier(true);
    _infoSM = PlayerEpisodeScope.infoSMOf(
      context,
      listen: false,
    );
    _isPlayingSubscription = _createIsPlayingSubscription();
    _isPlaying = _infoSM.state.isPlaying;
    _isCurrentRoute = true;
    _startHideTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isCurrentRoute = ModalRoute.isCurrentOf(context) ?? true;
    if (isCurrentRoute != _isCurrentRoute) {
      _isCurrentRoute = isCurrentRoute;
      // If route became inactive, show controls and cancel the timer.
      if (!_isCurrentRoute) {
        _timer?.cancel();
        _timer = null;
        _visible.value = true;
      } else {
        // If route became active, start the timer if needed.
        _startHideTimer();
      }
    }

    final infoSM = PlayerEpisodeScope.infoSMOf(context);
    if (infoSM != _infoSM) {
      _infoSM = infoSM;
      _isPlayingSubscription.cancel();
      _isPlayingSubscription = _createIsPlayingSubscription();
      _isPlaying = _infoSM.state.isPlaying;
      _visible.value = true;
      _startHideTimer();
    }
  }

  @override
  void dispose() {
    _isPlayingSubscription.cancel();
    _timer?.cancel();
    _visible.dispose();
    super.dispose();
  }

  /// Creates a subscription to listen to the playing state of the video.
  StreamSubscription<bool> _createIsPlayingSubscription() {
    final stream = _infoSM.stream.map((state) => state.isPlaying).distinct();
    return stream.listen(_onIsPlayingChanged);
  }

  /// Handles the change of the playing state of the video.
  ///
  /// [isPlaying] - the new playing state of the video.
  void _onIsPlayingChanged(bool isPlaying) {
    if (_isPlaying == isPlaying) {
      return;
    }
    _isPlaying = isPlaying;
    _isPlaying ? _startHideTimer() : _showControls();
  }

  void _startHideTimer() {
    // Don't start the timer if the video is paused or route is not current.
    if (!_isPlaying || !_isCurrentRoute) {
      return;
    }

    _timer?.cancel();
    _timer = Timer(_hideDelay, _onTimerTick);
  }

  void _onTimerTick() {
    // Don't hide controls if route is not current, video is paused, or widget is disposed.
    if (!mounted || !_isPlaying || !_isCurrentRoute) {
      return;
    }
    _visible.value = false;
  }

  void _showControls() {
    _timer?.cancel();
    _timer = null;

    _visible.value = true;

    // Start the timer only if the video is playing.
    if (_isPlaying) {
      _startHideTimer();
    }
  }

  /// Handles the pointer down event.
  void _onPointerDown() => _showControls();

  /// Handles the pointer move event.
  void _onPointerMove() => _showControls();

  /// Handles the pointer hover event.
  void _onPointerHover() => _showControls();

  /// Handles the pointer up event.
  void _onPointerUp() => _startHideTimer();

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      Listener(
        child: widget.child,
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) => _onPointerDown(),
        onPointerMove: (_) => _onPointerMove(),
        onPointerUp: (_) => _onPointerUp(),
        onPointerHover: (_) => _onPointerHover(),
      ),
      ...widget.additionalControls,
      ValueListenableBuilder(
        valueListenable: _visible,
        builder: (context, isShowControls, child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: isShowControls ? child : const SizedBox.shrink(),
        ),
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => _onPointerDown(),
          onPointerMove: (_) => _onPointerMove(),
          onPointerHover: (_) => _onPointerHover(),
          child: widget.controls,
        ),
      ),
    ],
  );
}
