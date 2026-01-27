import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  List<NewsArticlesModel> newsTopHeadLineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;
  String? errorMessage;
  String? selectedCategories;
  final BaseNewsRepository newsRepository;

  HomeController(this.newsRepository) {
    getTopHeadLine();
    getEverything();
  }

  getTopHeadLine({String? category}) async {
    try {
      topHeadLineStatus = RequestStatusEnum.loading;
      notifyListeners();
      newsTopHeadLineList = await newsRepository.getTopHeadLine(selectedCategories: selectedCategories);
      topHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything();
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }

  void updateSelectedCategories(String category) {
    selectedCategories = category;
    getTopHeadLine(category: selectedCategories);
    safeNotify();
  }
}
