import 'package:intl/intl.dart';

class NewsModel {
  final String title;
  final String author;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String articleUrl;

  NewsModel({
    required this.title,
    required this.author,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.articleUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      articleUrl:
          json['url']?.isNotEmpty == true ? json['url'] : 'No URL available',
      title: json['title']?.isNotEmpty == true
          ? json['title']
          : 'No title available',
      author: json['author']?.isNotEmpty == true
          ? json['author']
          : 'Unknown author',
      description: json['description']?.isNotEmpty == true
          ? json['description']
          : 'No description available',
      urlToImage:
          json['urlToImage']?.isNotEmpty == true ? json['urlToImage'] : '',
      publishedAt: _formatDate(json['publishedAt']),
      content: json['content']?.isNotEmpty == true
          ? json['content']
          : 'No content available',
    );
  }

  static String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) {
      return 'Unknown date';
    }
    try {
      final parsedDate = DateTime.parse(rawDate);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
