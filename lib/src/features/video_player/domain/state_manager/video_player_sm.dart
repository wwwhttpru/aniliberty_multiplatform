import 'dart:async';

import 'package:aniliberty_multiplatform/src/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state/video_player_controller_state.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'package:yx_state/yx_state.dart';

/// State type alias for video player state (uses VideoPlayerValue).
typedef VideoPlayerState = VideoPlayerValue;

/// State manager for video player information.
///
/// Tracks the video player's playback state by listening to changes in the
/// video player controller. Automatically updates when the controller changes
/// or when the player's value (position, duration, etc.) changes.
class VideoPlayerInfoSM extends StateManager<VideoPlayerState> {
  /// Readable state of the video player controller
  final StateReadable<VideoPlayerControllerState> _controllerReadable;

  /// Subscription to changes in the controller state
  StreamSubscription<VideoPlayerControllerState>? _onControllerSub;

  /// Subscription to changes in the video player value (position, duration, etc.)
  StreamSubscription<VideoPlayerValue>? _onValueSub;

  VideoPlayerInfoSM({
    required this._controllerReadable,
  }) : super(const VideoPlayerValue.uninitialized());

  /// Initializes the state manager and starts listening to controller changes.
  ///
  /// Sets up stream subscriptions to monitor changes in the video player controller
  /// and its playback state.
  @mustCallSuper
  Future<void> initialize() {
    assert(_onControllerSub == null, 'onControllerSub must be null');
    _onControllerSub = _controllerReadable.stream
        .startWith(_controllerReadable.state)
        .distinct()
        .listen(_onController);
    return Future<void>.value();
  }

  /// Handler for changes in the video player controller state.
  ///
  /// When a controller becomes available, starts listening to its value changes.
  /// When the controller is removed, cancels value subscription and sets state to uninitialized.
  void _onController(VideoPlayerControllerState value) {
    handle(
      (emit) async {
        final controller = value.maybeController;

        if (controller == null) {
          await _onValueSub?.cancel();
          _onValueSub = null;
          emit(const VideoPlayerValue.uninitialized());
          return;
        }

        _onValueSub ??= controller
            .toStream(() => controller.value)
            .distinct()
            .listen(_onValue);
        emit(controller.value);
      },
      identifier: '_onController',
    );
  }

  /// Handler for changes in the video player value (position, duration, etc.).
  ///
  /// Updates the state with the latest video player value.
  void _onValue(VideoPlayerValue value) {
    handle(
      (emit) {
        emit(value);
        return Future<void>.value();
      },
      identifier: '_onValue',
    );
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    assert(_onControllerSub != null, 'onControllerSub must not be null');
    await _onControllerSub?.cancel();
    _onControllerSub = null;
    await _onValueSub?.cancel();
    _onValueSub = null;
    return super.close();
  }
}
