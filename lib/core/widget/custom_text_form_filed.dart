import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.emailController,
    required this.title,
    required this.hintText,
    this.validator,
    this.maxLines,
    this.suffix,
  });

  final TextEditingController emailController;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final int? maxLines;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: emailController,
          validator:
              validator != null ? (String? value) => validator!(value) : null,
          // {
          //   if (value != null && value.isNotEmpty) {
          //     return '';
          //   }
          //   return "Enter your email";
          // },
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText, suffix: suffix),
        ),
      ],
    );
  }
}
