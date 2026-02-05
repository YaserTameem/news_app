import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';

class AuthRepository {
  AuthRepository(this.apiService);

  final ApiService apiService;

  Future<void> login({required String username, required String password}) async {
    await apiService.post(ApiConfig.login, ApiConfig.authBaseUrl, {
      "username": username,
      "password": password,
      "expiresInMins": 30,
    });
  }
}
