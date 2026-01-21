import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      builder: (context, _) {
        // final controller = context.read<HomeController>();
        return Consumer<HomeController>(
          builder: (BuildContext context, HomeController value, Widget? child) {
            return Scaffold(
              body: Column(
                children: [
                  TrendingNews(),
                  ViewAllComponent(
                    title: 'Categories',
                    titleColor: LightColors.textPrimaryColor,
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
