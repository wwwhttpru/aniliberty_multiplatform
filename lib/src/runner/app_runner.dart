// ignore_for_file: cascade_invocations

import 'dart:async';

import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:flutter/widgets.dart';

/// {@template app_runner}
/// App runner is responsible for running the app.
/// It initializes the app container and runs the app.
/// {@endtemplate}
class AppRunner {
  /// {@macro app_container_holder}
  final AppContainerHolder _holder;

  /// {@macro logger}
  final Logger _logger;

  /// {@macro app_runner}
  AppRunner() : _holder = AppContainerHolder(), _logger = Logger();

  /// Initialize the app container and run the app.
  Future<void> run() async => runZonedGuarded(
    () async {
      final binding = WidgetsFlutterBinding.ensureInitialized();
      binding.deferFirstFrame();

      // setup error handling
      FlutterError.onError = _logFlutterError;
      binding.platformDispatcher.onError = _logPlatformDispatcherError;

      // create input scope and create container
      final input = AppContainerInputScope(logger: _logger);

      // TODO(wwwhttpru): add error handle, if method throws error
      await _holder.create(input);

      // allow first frame
      binding.allowFirstFrame();

      // run app
      runApp(App(appContainerHolder: _holder));
    },
    _logZoneError,
  );

  void _logFlutterError(FlutterErrorDetails details) => _logger.log(
    details.toString(),
    level: LogLevel.error,
    error: details.exception,
    stackTrace: details.stack,
  );

  bool _logPlatformDispatcherError(Object error, StackTrace stackTrace) {
    _logger.log(
      'Platform Error',
      level: LogLevel.error,
      error: error,
      stackTrace: stackTrace,
    );

    return true;
  }

  void _logZoneError(Object error, StackTrace stackTrace) => _logger.log(
    'Zone error',
    level: LogLevel.error,
    error: error,
    stackTrace: stackTrace,
  );
}
