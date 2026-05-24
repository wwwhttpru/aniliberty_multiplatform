import 'dart:async';
import 'dart:math' as math;

import 'package:aniliberty_multiplatform/src/core/monitoring/monitoring.dart';
import 'package:dio/dio.dart';

/// {@template retry_dio_interceptor}
/// Interceptor for retrying requests uses exponential back-off.
/// {@endtemplate}
class RetryDioInterceptor extends Interceptor {
  /// {@macro logger}
  final Logger _logger;

  /// {@macro dio}
  final Dio _dio;

  /// Maximum retry count
  final int _maxRetryCount;

  /// Base delay for exponential back-off
  final Duration _baseDelay;

  /// Maximum delay cap for exponential back-off
  final Duration _maxDelay;

  /// Status codes when we should retry the request
  Set<int> get _statusCodes => const {
    408, // requestTimeout
    429, // tooManyRequests
    500, // internalServerError
    502, // badGateway
    503, // serviceUnavailable
    504, // gatewayTimeout
    440, // loginTimeout
    499, // clientClosedRequest
    460, // clientClosedRequest
    598, // networkReadTimeoutError
    599, // networkConnectTimeoutError
    520, // webServerReturnedUnknownError
    521, // webServerIsDown
    522, // connectionTimedOut
    523, // originIsUnreachable
    524, // timeoutOccurred
    525, // sslHandshakeFailed
    527, // railgunError
  };

  /// {@macro retry_dio_interceptor}
  const RetryDioInterceptor({
    required this._logger,
    required this._dio,
    this._maxRetryCount = 3,
    this._baseDelay = const Duration(seconds: 1),
    this._maxDelay = const Duration(seconds: 30),
  });

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // If request is cancelled, don't retry
    final cancelToken = err.requestOptions.cancelToken;
    if (cancelToken != null && cancelToken.isCancelled) {
      return handler.next(err);
    }

    // If retry count is greater than maximum retry count, don't retry
    final retryCount = err.requestOptions.retryCount + 1;
    if (retryCount > _maxRetryCount) {
      return handler.next(err);
    }

    // If request should not be retried, don't retry
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    // Calculate delay for the next attempt
    final delay = _delayForAttempt(retryCount);
    _logger.debug(
      'Retrying request (attempt $retryCount/$_maxRetryCount) '
      'after ${delay.inMilliseconds}ms: ${err.requestOptions.uri}',
    );

    // Create new request options with retry count
    final nextOptions = err.requestOptions.copyWith()
      ..setRetryCount(retryCount);

    // Retry request
    Future<void>.delayed(delay)
        .then((_) => _dio.fetch(nextOptions))
        .then(handler.resolve)
        .onError((_, __) => handler.next(err));
  }

  /// Computes delay for the given attempt using exponential back-off.
  /// Delay = min(baseDelay * 2^attempt, maxDelay).
  Duration _delayForAttempt(int attempt) {
    final exponentialMs = _baseDelay.inMilliseconds * math.pow(2, attempt - 1);
    final cappedMs = math.min(exponentialMs, _maxDelay.inMilliseconds);
    return Duration(milliseconds: cappedMs.toInt());
  }

  /// Checks if the request should be retried
  bool _shouldRetry(DioException err) {
    final statusCode = err.response?.statusCode;
    final type = err.type;
    final shouldRetryByStatusCode = _statusCodes.contains(statusCode);
    return switch (type) {
      .connectionTimeout ||
      .sendTimeout ||
      .receiveTimeout ||
      .connectionError => true,
      _ when shouldRetryByStatusCode => true,
      _ => false,
    };
  }
}

extension RetryRequestOptionsExtension on RequestOptions {
  /// Extra key for retry
  static const _retryExtraKey = 'retry';

  /// Get retry count from extra
  int get retryCount => (extra[_retryExtraKey] as int?) ?? 0;

  /// Set retry count to extra
  void setRetryCount(int count) => extra[_retryExtraKey] = count;

  /// Check if the request is a retry
  bool get isRetry => retryCount > 0;
}
