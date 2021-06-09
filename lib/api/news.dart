import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

import 'key.dart';

class News {
  List<Article> news = [];
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<void> getNews() async {
    final queryParameters = {'country': 'in', 'apiKey': '$apiKey'};
    try {
      final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
      final response = await client.get(uri);
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publshedAt: DateTime.parse(element['publishedAt']),
              content: element["content"],
              articleUrl: element["url"],
            );
            news.add(article);
          }
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class NewsForCategory {
  List<Article> news = [];
  Future<void> getNewsForCategory(String category) async {
    //String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publshedAt: DateTime.parse(element['publishedAt']),
              content: element["content"],
              articleUrl: element["url"],
            );
            news.add(article);
          }
        },
      );
    }
  }
}
