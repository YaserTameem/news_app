import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          return Column(
            children: [
              ViewAllComponent(
                title: 'Categories',
                titleColor: LightColors.textPrimaryColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ChangeNotifierProvider.value(
                            value: context.read<HomeController>(),
                            child: CategoriesScreen(),
                          ),
                    ),
                  );
                },
              ),
              Padding(
                padding:  EdgeInsets.only(top: AppSizes.ph8, bottom: AppSizes.ph16, left: AppSizes.pw16),
                child: SizedBox(
                  height: AppSizes.h30,
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
