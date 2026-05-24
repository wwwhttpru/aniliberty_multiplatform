import 'dart:developer' as developer;

import 'package:aniliberty_multiplatform/src/core/monitoring/logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

/// {@template logger_listener}
/// A listener for log messages.
/// {@endtemplate}
abstract interface class LoggerListener {
  /// Called when a log message is received.
  Future<void> onLogMessage(LogMessage logMessage);
}

/// A listener for log messages that prints them to the console.
@immutable
class DeveloperLoggerListener implements LoggerListener {
  /// Creates a new instance of the [DeveloperLoggerListener] class.
  const DeveloperLoggerListener();

  @override
  Future<void> onLogMessage(LogMessage logMessage) {
    final stackTrace = logMessage.stackTrace;

    developer.log(
      logMessage.message,
      time: logMessage.timestamp,
      error: logMessage.error,
      level: switch (logMessage.level) {
        LogLevel.debug => 700,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
        LogLevel.fatal => 1200,
      },
      name: switch (logMessage.level) {
        LogLevel.debug => 'DEBUG',
        LogLevel.info => 'INFO',
        LogLevel.warning => 'WARNING',
        LogLevel.error => 'ERROR',
        LogLevel.fatal => 'FATAL',
      },
      stackTrace: switch (stackTrace) {
        StackTrace() => Trace.from(stackTrace).terse,
        null => null,
      },
    );

    return Future<void>.value();
  }
}
