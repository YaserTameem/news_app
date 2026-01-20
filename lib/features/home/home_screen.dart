import 'package:flutter/material.dart';
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
              body:
                  (value.errorMessage?.isNotEmpty ?? false)
                      ? Center(child: Text(value.errorMessage!))
                      : value.topHeadLineLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: value.newsTopHeadLineList.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  value.newsTopHeadLineList[index].title,
                                );
                              },
                            ),
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
