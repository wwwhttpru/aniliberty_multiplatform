import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:meta/meta.dart';
import 'package:yx_state/yx_state.dart';

/// {@template state_manager_logger}
/// A logger for state managers.
/// {@endtemplate}
class StateManagerLogger extends StateManagerObserver {
  /// {@macro logger}
  final Logger _logger;

  /// The default state manager observer.
  StateManagerObserver? _default;

  /// {@macro state_manager_logger}
  StateManagerLogger({
    required this._logger,
  });

  /// Initializes the state manager logger.
  @mustCallSuper
  Future<void> initialize() {
    _default = StateManagerOverrides.observer;
    StateManagerOverrides.observer = this;
    return Future<void>.value();
  }

  /// Closes the state manager logger.
  @mustCallSuper
  Future<void> close() {
    final value = _default;
    if (value == null) {
      assert(false, 'Default state manager observer is not set');
      return Future<void>.value();
    }
    StateManagerOverrides.observer = value;
    return Future<void>.value();
  }

  @override
  void onError(
    StateManagerBase<Object?> stateManager,
    Object error,
    StackTrace stackTrace,
    Object? identifier,
  ) {
    _logger.error('State manager:', error: error, stackTrace: stackTrace);
    return super.onError(stateManager, error, stackTrace, identifier);
  }
}
