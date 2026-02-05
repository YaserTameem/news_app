import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class BookmarkRepository {
  BookmarkRepository._internal();

  static final BookmarkRepository _instance = BookmarkRepository._internal();

  factory BookmarkRepository() => _instance;

  Box<BookmarkModel>? _bookmarkBox;

  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception("BookmarkRepository not initialized.");
    }
    return _bookmarkBox!;
  }

  Future<void> init() async {
    Hive.registerAdapter(BookmarkModelAdapter());
    _bookmarkBox = await Hive.openBox<BookmarkModel>(Constants.bookmarkBox);
  }


  /// Create a BookmarkModel from [article] and save it.
  Future<void> addBookmark(NewsArticlesModel article) async {
    final bookmark = BookmarkModel(
      url: article.url,
      title: article.title,
      description: article.description,
      urlToImage: article.urlToImage,
      author: article.author,
      publishedAt: article.publishedAt,
      content: article.content,
      savedAt: DateTime.now(),
    );
    await bookmarkBox.put(article.url, bookmark);
  }
  Future<void> removeBookmark(String articleUrl) async {
    await bookmarkBox.delete(articleUrl);
  }

  List<BookmarkModel> getBookmarks() => bookmarkBox.values.toList();

  bool isBookmarked(String? articleUrl) {
    if (articleUrl == null || articleUrl.isEmpty) return false;
    return bookmarkBox.containsKey(articleUrl);
  }
  BookmarkModel? getBookmark(String articleUrl) {
    return bookmarkBox.get(articleUrl);
  }

  Future<bool> toggleBookmark(NewsArticlesModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookmark(article.url);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  int getBookmarkCount() => bookmarkBox.length;


  Future<void> clearAllBookmark() async {
    await bookmarkBox.clear();
  }

  List<BookmarkModel> searchBookmarks(String query) {
    if (query.isEmpty) return getBookmarks();
    final lowerCaseQuery = query.trim().toLowerCase();
    return bookmarkBox.values.where((bookmark) {
      final titleMatch = bookmark.title.toLowerCase().contains(lowerCaseQuery);
      final descriptionMatch = bookmark.description.toLowerCase().contains(lowerCaseQuery);
      final authorMatch = bookmark.author.toLowerCase().contains(lowerCaseQuery);
      return titleMatch || descriptionMatch || authorMatch;
    }).toList()
      ..sort((a, b) => b.savedAt.compareTo(a.savedAt));
  }


  /// Convert a [BookmarkModel] into a [NewsArticlesModel].
  NewsArticlesModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticlesModel(
      author: bookmark.author,
      title: bookmark.title,
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content,
    );
  }
}
