import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class HomeController with ChangeNotifier {
  List<NewsArticlesModel> newsTopHeadLineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  ApiService apiService = ApiService();

  bool topHeadLineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  getTopHeadLine() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        {'country': 'us'},
      );

      newsTopHeadLineList =
          (result["articles"] as List)
              .map((e) => NewsArticlesModel.fromJson(e))
              .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.everything, {
        'q': 'ai',
      });

      newsEverythingList =
          (result["articles"] as List)
              .map((e) => NewsArticlesModel.fromJson(e))
              .toList();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
    }
    notifyListeners();
  }
}
