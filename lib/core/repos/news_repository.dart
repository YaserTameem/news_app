import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticlesModel>> getTopHeadLine({String? selectedCategories = 'general'});

  Future<List<NewsArticlesModel>> getEverything({String? query = 'news'});
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiService);

  final BaseApiService apiService;

  @override
  Future<List<NewsArticlesModel>> getTopHeadLine({String? selectedCategories = 'general'}) async {
    Map<String, dynamic> result = await apiService.get(ApiConfig.topHeadlines, ApiConfig.newsBaseUrl, {
      'country': 'us',
      'category': selectedCategories,
    });

    return (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
  }

  @override
  Future<List<NewsArticlesModel>> getEverything({String? query = 'news'}) async {
    Map<String, dynamic> result = await apiService.get(ApiConfig.everything, ApiConfig.newsBaseUrl, {
      'q': query,
    });

    return (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
  }
}
