import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsRepository {
  final String _apiKey = '6c6d0f4b846c457b9666e47b7c2bf66c';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl&apiKey=$_apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'];
        return articles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching news: $e');
    }
  }
}
