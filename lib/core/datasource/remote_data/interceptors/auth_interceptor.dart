import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/main.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigatorKey.currentContext!;
      UserRepository().deleteUser();
      PreferencesManager().remove('is_logged_in');
      Navigator.of(
        context,
      ).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: LightColors.primaryColor,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Session expired. Please log in again.',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    handler.next(err);
  }
}
