import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_text_form_filed.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/repo/auth_repository.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepository(ApiService())),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.requestStatusEnum == RequestStatusEnum.loaded) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: _key,
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final controller = context.read<AuthCubit>();
                  return Padding(
                    padding: EdgeInsets.all(AppSizes.pw16),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Image.asset("assets/images/logo.png", height: AppSizes.h45)),
                            SizedBox(height: AppSizes.ph40),
                            Text(
                              "Welcome to Newts",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: AppSizes.sp20),
                            ),
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
                            SizedBox(height: AppSizes.ph16),

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
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: passwordController,
                              title: 'Password',
                              hintText: '*************',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }

                                final RegExp passwordRegex = RegExp(r'^(?=.*\d).{8,}$');

                                if (!passwordRegex.hasMatch(value)) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: confirmPasswordController,
                              title: 'Confirm Password',
                              hintText: '*************',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }

                                final RegExp passwordRegex = RegExp(r'^(?=.*\d).{8,}$');

                                if (!passwordRegex.hasMatch(value)) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: AppSizes.ph8),
                                child: Text(state.errorMessage!, style: TextStyle(color: Colors.red)),
                              ),
                            SizedBox(height: AppSizes.ph24),
                            SizedBox(
                              width: double.infinity,
                              height: AppSizes.h48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState?.validate() ?? false) {
                                    controller.register(
                                      name: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child:
                                    state.requestStatusEnum == RequestStatusEnum.loading
                                        ? CircularProgressIndicator()
                                        : Text('Sign Up'),
                              ),
                            ),
                            SizedBox(height: AppSizes.ph24),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "Have an account ?  ",
                                  style: TextStyle(
                                    fontSize: AppSizes.sp14,
                                    fontWeight: FontWeight.w400,
                                    color: LightColors.textPrimaryColor,
                                  ),

                                  children: [
                                    TextSpan(
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pop(context);
                                            },
                                      text: 'Sign In',
                                      style: TextStyle(
                                        fontSize: AppSizes.sp14,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
