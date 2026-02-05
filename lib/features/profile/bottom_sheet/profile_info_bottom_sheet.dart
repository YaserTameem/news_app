import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/core/widgets/custom_text_form_filed.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? username;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final UserModel? user = await UserRepository().getUser();
    if (user != null) {
      usernameController.text = user.name;
      emailController.text = user.email!;
    }
  }

  void _saveUserData() async {
    if (_key.currentState?.validate() ?? false) {
      await UserRepository().updateUser(name: usernameController.text, email: emailController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r16),
          topRight: Radius.circular(AppSizes.r16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: AppSizes.ph16),
                    width: AppSizes.w32,
                    height: AppSizes.h4,
                    decoration: BoxDecoration(
                      color: Color(0xFF363636),
                      borderRadius: BorderRadius.circular(AppSizes.r100),
                    ),
                  ),
                ),
                Text('Profile Info', style: TextStyle(color: Color(0xFF141414), fontSize: 16)),
                SizedBox(height: AppSizes.ph16),
                CustomTextFormField(
                  controller: emailController,
                  title: 'Email',
                  hintText: 'usama@gmail.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    // final RegExp emailRegex = RegExp(
                    //   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    // );
                    // if (!emailRegex.hasMatch(value)) {
                    //   return 'Please Enter Valid Email';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.ph12),

                CustomTextFormField(
                  controller: usernameController,
                  title: 'User Name',
                  hintText: 'Yaser Tameem',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Username';
                    }
                    // final RegExp emailRegex = RegExp(
                    //   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    // );
                    // if (!emailRegex.hasMatch(value)) {
                    //   return 'Please Enter Valid Email';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.ph40),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, AppSizes.h48),
                  ),
                  onPressed: () {
                    _saveUserData();
                  },
                  child: Text('Save'),
                ),
                SizedBox(height: AppSizes.ph16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
