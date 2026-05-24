import 'dart:async';

/// Log level, that describes the severity of the log message
///
/// Index of the log level is used to determine the severity of the log message.
enum LogLevel {
  /// A log level used for events considered to be useful during software
  /// debugging when more granular information is needed.
  debug,

  /// An event happened, the event is purely informative
  /// and can be ignored during normal operations.
  info,

  /// Unexpected behavior happened inside the application, but it is continuing
  /// its work and the key business features are operating as expected.
  warning,

  /// One or more functionalities are not working,
  /// preventing some functionalities from working correctly.
  /// For example, a network request failed, a file is missing, etc.
  error,

  /// One or more key business functionalities are not working
  /// and the whole system doesn’t fulfill the business functionalities.
  fatal;

  const LogLevel();
}

/// {@template log_message}
/// Represents a single log message with various details
/// for debugging and information purposes.
/// {@endtemplate}
class LogMessage {
  /// The main content of the log message.
  final String message;

  /// The severity level of the log message.
  final LogLevel level;

  /// The date and time when the log message was created.
  final DateTime timestamp;

  /// Any error object associated with the log message.
  ///
  /// This is typically used when the log message is related
  /// to an exception or error condition.
  final Object? error;

  /// The stack trace associated with the log message.
  ///
  /// This provides detailed information about the call stack leading
  /// up to the log message, which is particularly useful when logging errors.
  final StackTrace? stackTrace;

  /// Additional contextual information provided as a map.
  final Map<String, Object?>? context;

  /// Constructs an instance of [LogMessage].
  const LogMessage({
    required this.message,
    required this.level,
    required this.timestamp,
    this.error,
    this.stackTrace,
    this.context,
  });
}

/// {@template logger}
/// Logger class, that manages the logging of messages
/// {@endtemplate}
class Logger {
  final _controller = StreamController<LogMessage>.broadcast();

  /// Stream of log messages
  Stream<LogMessage> get logMessageStream => _controller.stream;

  /// Constructs an instance of [Logger].
  Logger();

  /// Disposes the logger.
  Future<void> close() => _controller.close();

  /// Logs a message with the specified [level].
  void log(
    String message, {
    required LogLevel level,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    final logMessage = LogMessage(
      message: message,
      level: level,
      timestamp: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
      context: context,
    );

    _controller.add(logMessage);
  }

  /// Logs a message with [LogLevel.debug].
  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    message,
    level: LogLevel.debug,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Logs a message with [LogLevel.info].
  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    message,
    level: LogLevel.info,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Logs a message with [LogLevel.warning].
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    message,
    level: LogLevel.warning,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Logs a message with [LogLevel.error].
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    message,
    level: LogLevel.error,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );

  /// Logs a message with [LogLevel.fatal].
  void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => log(
    message,
    level: LogLevel.fatal,
    error: error,
    stackTrace: stackTrace,
    context: context,
  );
}
