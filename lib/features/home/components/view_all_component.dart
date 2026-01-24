import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_colors.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({super.key, required this.title, this.titleColor, required this.onTap});

  final String title;
  final Color? titleColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppSizes.ph16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? LightColors.buttonTextColor,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => onTap(),
            child: Text(
              "View all",
              style: TextStyle(
                fontSize: AppSizes.sp14,
                color: titleColor ?? LightColors.buttonTextColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
