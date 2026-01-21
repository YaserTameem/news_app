import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class HomeController with ChangeNotifier {
  List<NewsArticlesModel> newsTopHeadLineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;
  String? errorMessage;

  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  getTopHeadLine() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.topHeadlines, {'country': 'us'});

      newsTopHeadLineList = (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
      topHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.everything, {'q': 'ai'});

      newsEverythingList = (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    notifyListeners();
  }
}
