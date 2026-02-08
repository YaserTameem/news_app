import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/datasource/remote_data/news/news_api_config.dart';
import 'package:news_app/core/datasource/remote_data/news/news_dio_config.dart';
import 'package:news_app/main.dart';

abstract class BaseNewsApiService {
  Future<dynamic> get(String endPoint, Map<String, dynamic>? params);
}

class NewsApiService extends BaseNewsApiService {
  final dio = NewsDioConfig.createDio();

  @override
  Future<dynamic> get(String endPoint, Map<String, dynamic>? params) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: {'apiKey': NewsApiConfig.apiKey, ...?params},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      String message;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connection timeout.';
          break;

        case DioExceptionType.sendTimeout:
          message = 'Request timeout.';
          break;

        case DioExceptionType.receiveTimeout:
          message = 'Server not responding.';
          break;

        case DioExceptionType.badCertificate:
          message = 'Secure connection error.';
          break;

        case DioExceptionType.badResponse:
          message = 'Server error.';
          break;

        case DioExceptionType.cancel:
          message = 'Request cancelled.';
          break;

        case DioExceptionType.connectionError:
          message = 'No internet connection.';
          break;

        case DioExceptionType.unknown:
          message = 'Unexpected error.';
          break;
      }

      final context = navigatorKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
      }
    }
  }
}
