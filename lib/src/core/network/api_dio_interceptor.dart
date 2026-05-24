import 'package:aniliberty_multiplatform/src/core/network/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/core/network/retry_dio_interceptor.dart';
import 'package:dio/dio.dart';

/// {@template api_dio_interceptor}
/// Interceptor for API requests.
///
/// This interceptor handles timing out requests and
/// retries them with the next base URL.
/// {@endtemplate}
class ApiDioInterceptor implements Interceptor {
  /// The original dio
  final Dio _dio;

  /// {@macro api_url_interactor}
  final IApiUrlInteractor _apiUrlInteractor;

  /// {@macro api_dio_interceptor}
  ApiDioInterceptor({
    required this._dio,
    required this._apiUrlInteractor,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // If the domain is already changed, pass it to the next interceptor
    if (options.domainChanged || options.isRetry) {
      return handler.next(options);
    }

    final nextOptions = options.copyWith();
    final nextBaseUrl = _apiUrlInteractor.activeBaseUrl;
    nextOptions
      ..baseUrl = nextBaseUrl
      ..setDomainChanged();

    // Pass the next options to the next interceptor with the new base URL
    handler.next(nextOptions);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // If the request is a retry, pass it to the next interceptor.
    //
    // When retry interceptor reached the maximum retry count,
    // it will pass the error to the next interceptor with [isRetry] equals to false.
    // That means we skip this condition.
    if (err.requestOptions.isRetry) {
      return handler.next(err);
    }

    /// Check if the error is a timeout
    final isTimeout = switch (err.type) {
      .connectionTimeout || .receiveTimeout => true,
      // Sometimes API throw unknown error, so we need to try retry
      .unknown => true,
      _ => false,
    };

    // If the error is not a timeout, pass it to the next interceptor
    if (!isTimeout) {
      return handler.next(err);
    }

    // Get the base URL from the request options
    final baseUrl = err.requestOptions.baseUrl;

    // Mark base URL as failed
    _apiUrlInteractor.markAsFailedBaseUrl(baseUrl);

    // Check if the API attempt should be incremented
    final shouldRetry = _apiUrlInteractor.shouldSwitchToNextBaseUrl(baseUrl);

    // If the API attempt should not be incremented, pass it to the next interceptor
    if (!shouldRetry) {
      return handler.next(err);
    }

    final nextBaseUrl = _apiUrlInteractor.activeBaseUrl;
    final options = err.requestOptions.copyWith(baseUrl: nextBaseUrl);

    // Fetch the request with the next base URL
    _dio
        .fetch(options)
        .then(handler.resolve)
        .onError((_, __) => handler.next(err));
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final baseUrl = response.requestOptions.baseUrl;
    _apiUrlInteractor.markAsSuccessBaseUrl(baseUrl);
    return handler.next(response);
  }
}

extension on RequestOptions {
  /// Extra key mark that domain is changed
  static const _domainChangedKey = 'domain_changed';

  /// Get the domain changed from the extra
  bool get domainChanged => extra[_domainChangedKey] as bool? ?? false;

  /// Set the domain changed in the extra
  void setDomainChanged() => extra[_domainChangedKey] = true;
}
