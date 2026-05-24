import 'dart:convert';

import 'package:aniliberty_multiplatform/src/core/monitoring/monitoring.dart';
import 'package:aniliberty_multiplatform/src/core/network/api_dio_interceptor.dart';
import 'package:aniliberty_multiplatform/src/core/network/app_dio_transformer.dart';
import 'package:aniliberty_multiplatform/src/core/network/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/core/network/retry_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract interface class AppNetwork {
  abstract final Dio coreV2;
}

final class AppNetworkImpl implements AppNetwork {
  /// {@macro logger}
  final Logger _logger;

  /// {@macro api_url_interactor}
  final IApiUrlInteractor _apiUrlInteractor;

  Dio? _coreV2;

  @override
  Dio get coreV2 {
    final core = _coreV2;

    if (core == null) {
      throw Exception();
    }

    return core;
  }

  AppNetworkImpl({
    required this._logger,
    required this._apiUrlInteractor,
  });

  @mustCallSuper
  Future<void> initialize() async {
    // Shorter per-attempt timeouts work better with retry: fail fast, then retry.
    // Worst case per attempt ~20s; with 2 retries + backoff total is still bounded.
    final optionsV2 = BaseOptions(
      baseUrl: _apiUrlInteractor.activeBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 5),
      validateStatus: (s) => s != null && s >= 200 && s < 300,
      headers: const {'Accept': 'application/json'},
      contentType: 'application/json',
      followRedirects: true,
      maxRedirects: 5,
      receiveDataWhenStatusError: true,
      responseDecoder: (responseBytes, _, __) => utf8.decode(responseBytes),
      requestEncoder: (request, options) => utf8.encode(request),
    );

    // Setup dio
    final coreV2 = Dio(optionsV2);

    // Setup transformer
    final defaultTransformer = coreV2.transformer;
    coreV2.transformer = AppDioTransformer(transformer: defaultTransformer);

    // Setup retry interceptor
    final retryDioInterceptor = RetryDioInterceptor(
      logger: _logger,
      dio: coreV2,
    );
    coreV2.interceptors.add(retryDioInterceptor);

    // Setup API interceptor
    final apiDioInterceptor = ApiDioInterceptor(
      dio: coreV2,
      apiUrlInteractor: _apiUrlInteractor,
    );
    coreV2.interceptors.add(apiDioInterceptor);

    // Setup core
    _coreV2 = coreV2;
  }

  @mustCallSuper
  Future<void> dispose() async {
    _coreV2?.close(force: true);
    _coreV2 = null;
  }
}
