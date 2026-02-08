import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_dio_config.dart';
import 'package:news_app/main.dart';

abstract class AuthBaseApiService {
  Future<dynamic> post(String endpoint, String baseUrl, {Map<String, dynamic>? body});
}

class ApiService extends AuthBaseApiService {
  final dio = AuthDioConfig.createDio();

  @override
  Future<dynamic> post(String endpoint, String baseUrl, {Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(endpoint, data: jsonEncode(body));

      final responseBody = response.data as Map<String, dynamic>;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Failed To load Data");
      }
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  void _handleDioException(DioException e) {
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
