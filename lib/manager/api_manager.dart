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
  static const String apiKey = "e34182266905435bb3039fa6de9eb4db";

  static Future<SoursesResponceModel?> getSources() async {
    var params = {
      "apiKey": apiKey,
    };
    Uri url = Uri.https(baseUrl, EndPoints.sources, params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      SoursesResponceModel sourcesResponse =
          SoursesResponceModel.fromJson(json);
      return sourcesResponse;
    } else {
      throw Exception("Failed to load sources");
    }
  }

  static Future<ArticleModel?> getArticles() async {
    var params = {
      "apiKey": apiKey,
      "q": "messi",
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
