import 'dart:async';

import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:meta/meta.dart';

/// {@template logger_interactor}
/// Handle log messages and send to listeners
/// {@endtemplate}
class LoggerInteractor {
  /// {@macro logger}
  final Logger _logger;

  /// {@macro logger_listener}
  final List<LoggerListener> _listeners;

  /// Subscription for log message stream
  StreamSubscription<LogMessage>? _onLogMessageSub;

  /// Creates a new instance of the [LoggerInteractor] class.
  LoggerInteractor({
    required this._logger,
    required List<LoggerListener> listeners,
  }) : _listeners = [...listeners];

  /// Initializes the interactor.
  @mustCallSuper
  Future<void> initialize() {
    assert(_onLogMessageSub == null, 'Log message subscription must be null');

    _onLogMessageSub ??= _logger.logMessageStream.listen(_onLogMessage);
    return Future<void>.value();
  }

  /// Closes the interactor.
  @mustCallSuper
  Future<void> close() async {
    assert(
      _onLogMessageSub != null,
      'Log message subscription must not be null',
    );

    await _onLogMessageSub?.cancel();
    _onLogMessageSub = null;
  }

  /// Add logger listener
  void add(LoggerListener value) => _listeners.add(value);

  /// Remove logger listener
  void remove(LoggerListener value) => _listeners.remove(value);

  /// Called when a log message is received.
  void _onLogMessage(LogMessage logMessage) {
    for (final listener in _listeners) {
      listener.onLogMessage(logMessage).ignore();
    }
  }
}
