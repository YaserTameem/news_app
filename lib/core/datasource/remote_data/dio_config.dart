import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/auth_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/logging_interceptor.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com/",
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      ),
    );
    dio.interceptors.addAll([LoggingInterceptor(), AuthInterceptor()]);
    return dio;
  }
}
