import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/models/user_model.dart';

class UserRepository {
  UserRepository._internal();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;
  Box<UserModel>? _userBox;

  init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    _userBox = await Hive.openBox(Constants.userBox);
  }

  saveUser(UserModel user) async {
    await _userBox?.put(Constants.currentUser, user);
  }

  getUser() {
    return _userBox?.get(Constants.currentUser);
  }

  updateUser({
    String? name,
    String? email,
    String? password,
    String? countryCode,
    String? countryName,
  }) async {
    final UserModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryCode: countryCode,
        countryName: countryName,
      );
      await saveUser(updatedUser);
    }
  }
}
