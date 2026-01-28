import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/models/user_model.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;
  String? username;
  String? countryName;
  String? countryCode;

  ProfileController() {
    getUserData();
  }

  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  Future<void> getUserData() async {
    final UserModel? user = await UserRepository().getUser();
    username = user?.name ?? '';
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
