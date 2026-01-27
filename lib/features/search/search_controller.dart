import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotify {
  SearchScreenController(this.newsRepository);
  List<NewsArticlesModel> newsEverythingList = [];
  String? errorMessage;
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  final TextEditingController searchTextEditingController = TextEditingController();
final BaseNewsRepository newsRepository;
  getEverything( ) async {
    try {
      newsEverythingList = await newsRepository.getEverything(query: searchTextEditingController.text);
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }


}