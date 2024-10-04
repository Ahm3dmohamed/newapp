import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/sourses_responce_model.dart';

class EndPoints {
  static const String sources = "/v2/top-headlines/sources";
  static const String articleUrl = "/v2/everything";
}

class ApiManager {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "f766fc89b5694cc68b5b5c79c7744b50";

  static Future<SoursesResponceModel?> getSources(
    String sourceName,
  ) async {
    try {
      var params = {
        "apiKey": apiKey,
        'category': sourceName,
      };
      Uri url = Uri.https(baseUrl, EndPoints.sources, params);

      http.Response response = await http.get(url);
      if (response.statusCode == 429) {
        print('Too many requests - please try again later');
      }
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        SoursesResponceModel sourcesResponse =
            SoursesResponceModel.fromJson(json);
        return sourcesResponse;
      } else {
        print('Failed to load sources: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<ArticleModel?> getArticles(
    String id,
  ) async {
    var params = {
      "apiKey": apiKey,
      "q": id,
      "pageSize": "20",
    };
    Uri url = Uri.https(baseUrl, EndPoints.articleUrl, params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      ArticleModel articleResponse = ArticleModel.fromJson(json);
      return articleResponse;
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
