import 'package:brotli/brotli.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppDioTransformer implements Transformer {
  final Transformer _transformer;

  const AppDioTransformer({
    required this._transformer,
  });

  @override
  Future<String> transformRequest(
    RequestOptions options,
  ) => _transformer.transformRequest(options);

  @override
  Future<Object?> transformResponse(
    RequestOptions options,
    ResponseBody responseBody,
  ) {
    // Disable brotli on web
    //
    // See <https://github.com/tiagohm/brotli/issues/3> for more information.
    if (kIsWeb) {
      return _transformer.transformResponse(options, responseBody);
    }

    if (_isBrotliEncoding(responseBody)) {
      responseBody.stream = responseBody.stream
          .cast<List<int>>()
          .transform(brotli.decoder)
          .map(Uint8List.fromList);
    }

    return _transformer.transformResponse(options, responseBody);
  }

  /// Checks if the response is encoded with brotli.
  bool _isBrotliEncoding(ResponseBody response) {
    final content = response.headers['content-encoding'];

    if (content != null && content.isNotEmpty) {
      return content.first.toLowerCase() == 'br';
    }

    return false;
  }
}
