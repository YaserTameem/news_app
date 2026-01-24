import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_cached_network_image.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSizes.ph8, bottom: AppSizes.ph16, left: AppSizes.pw16),
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: AppSizes.pw16),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: AppSizes.pw12);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = value.selectedCategories == categories[index];
                      return GestureDetector(
                        onTap: () => value.updateSelectedCategories(categories[index]),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() + categories[index].substring(1),
                                style: TextStyle(
                                  color: LightColors.textSecondaryColor,
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: AppSizes.ph4),
                                Container(height: AppSizes.h2, color: LightColors.primaryColor),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.newsTopHeadLineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = value.newsTopHeadLineList[index];
                    return NewsItem(model: model);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
}
