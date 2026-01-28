import 'package:hive_ce_flutter/adapters.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String urlToImage;

  @HiveField(4)
  final String author;

  @HiveField(5)
  final DateTime publishedAt;

  @HiveField(6)
  final String content;

  @HiveField(7)
  final DateTime savedAt;

  BookmarkModel({
    required this.url,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.author,
    required this.publishedAt,
    required this.content,
    required this.savedAt,
  });

  BookmarkModel copyWith({
    String? url,
    String? title,
    String? description,
    String? urlToImage,
    String? author,
    DateTime? publishedAt,
    String? content,
    DateTime? savedAt,
  }) {
    return BookmarkModel(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      urlToImage: urlToImage ?? this.urlToImage,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  factory BookmarkModel.fromJson(Map<String, dynamic> map) {
    return BookmarkModel(
      url: map['url'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      author: map['author'] ?? '',
      publishedAt: DateTime.tryParse(map['publishedAt'] ?? '') ?? DateTime.now(),
      content: map['content'] ?? '',
      savedAt: DateTime.tryParse(map['savedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
