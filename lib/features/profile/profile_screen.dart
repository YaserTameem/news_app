import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/bottom_sheet/profile_info_bottom_sheet.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.ph24, horizontal: AppSizes.pw16),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (BuildContext context, state) {
              final controller = context.read<ProfileCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  state.selectedImage == null
                                      ? AssetImage('assets/images/profile_image.png')
                                      : FileImage(File(state.selectedImage!.path)),
                              radius: AppSizes.r60,
                            ),
                            GestureDetector(
                              onTap: () {
                                showImageSourceDialog(context);
                              },
                              child: Container(
                                width: AppSizes.w34,
                                height: AppSizes.h34,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(AppSizes.r100),
                                ),
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.ph8),
                        Text(
                          state.username ?? '',
                          style: TextStyle(
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF161F1B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizes.ph16),
                  _buildProfileItem(
                    title: 'Personal Info',
                    path: 'assets/images/user_image.svg',
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return ProfileInfoBottomSheet();
                        },
                      ).then((value) {
                        controller.getUserData();
                      });
                    },
                  ),
                  _buildProfileItem(
                    title: 'Language',
                    path: 'assets/images/globe_icon.svg',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    title: state.countryName ?? 'Country',
                    path: 'assets/images/flag_icon4.svg',
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          controller.saveCountry(country);
                        },
                      );
                    },
                  ),
                  _buildProfileItem(
                    title: 'Terms & Conditions',
                    path: 'assets/images/file_icon.svg',
                    onTap: () {},
                  ),
                  _buildProfileItem(
                    title: 'Logout',
                    path: 'assets/images/log_out_icon.svg',
                    onTap: () async {
                      await PreferencesManager().clear();
                      await UserRepository().deleteUser();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    color: LightColors.primaryColor,
                    withDivider: false,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(BuildContext context) {
    final controller = context.read<ProfileCubit>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Text("Select Image Source", style: TextStyle(fontSize: AppSizes.sp16)),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: AppSizes.pw8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: AppSizes.pw8),
                  Text("Galley"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileItem({
    required String path,
    required String title,
    required Function onTap,
    Color color = const Color(0xFF161F1B),
    bool withDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(),
          contentPadding: EdgeInsets.zero,
          leading: CustomSvgPicture.withoutColor(path: path),
          title: Text(title),
          titleTextStyle: TextStyle(fontSize: AppSizes.sp16, color: color),
          trailing: Icon(Icons.arrow_forward_ios_outlined, color: color, size: AppSizes.r20),
        ),
        withDivider ? Divider(color: Color(0xFFD1DAD6)) : SizedBox(),
      ],
    );
  }
}
