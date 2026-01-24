import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.emailController,
    required this.title,
    required this.hintText,
    this.validator,
    this.maxLines = 1,
    this.suffix,
    this.obscureText = false,
  });

  final TextEditingController emailController;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final int? maxLines;
  final Widget? suffix;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: AppSizes.ph8),
        TextFormField(
          controller: widget.emailController,
          validator:
              widget.validator != null
                  ? (String? value) => widget.validator!(value)
                  : null,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText && !_isVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon:
                          _isVisible
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
