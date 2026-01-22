import 'package:flutter/material.dart';
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
                   Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16, left: 16),
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 12);
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: 4),
                                Container(height: 2, color: LightColors.primaryColor),
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
