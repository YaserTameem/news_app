import 'dart:developer';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("Method: ${options.method}");
    if (options.queryParameters.isNotEmpty) {
      log("Query Parameters: ${options.queryParameters}");
    }
    if (options.data != null) {
      log("Data: ${options.data}");
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {}
}
