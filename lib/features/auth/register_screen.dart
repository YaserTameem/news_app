import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_text_form_filed.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? errorMessage;

  bool isLoading = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    final savedEmail = PreferencesManager().getString("user_email");
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = 'User Already Register';
        isLoading = false;
      });
    } else {
      await PreferencesManager().setString(
        "user_email",
        emailController.text.trim(),
      );
      await PreferencesManager().setString(
        "user_password",
        passwordController.text.trim(),
      );
      await PreferencesManager().setBool("is_logged_in", true);
      setState(() {
        isLoading = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Padding(
            padding:  EdgeInsets.all(AppSizes.pw16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png", height: AppSizes.h45),
                ),
                SizedBox(height: AppSizes.ph40),
                Text(
                  "Welcome to Newts",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: AppSizes.sp20),
                ),
                SizedBox(height: AppSizes.ph16),

                CustomTextFormField(
                  emailController: emailController,
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
                SizedBox(height: AppSizes.ph24),
                CustomTextFormField(
                  emailController: passwordController,
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
                  emailController: confirmPasswordController,
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
                if (errorMessage != null)
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: AppSizes.ph8),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: AppSizes.ph24),
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.h48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        register();
                      }
                    },
                    child:
                        isLoading
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
      ),
    );
  }
}
