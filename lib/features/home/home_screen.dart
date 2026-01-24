import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          // final controller = context.read<HomeController>();
          return Scaffold(
            body: CustomScrollView(slivers: [TrendingNews(), CategoriesList(), TopHeadline()]),
          );
        },
      ),
    );
  }
}
