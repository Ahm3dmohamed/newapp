import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/source_model.dart';

class EndPoints {
  static const String sources = "/v2/top-headlines/sources";
  static const String articleUrl = "/v2/everything";
}

class ApiManager {
  static const String baseUrl = "newsapi.org";
  // static const String apiKey = "37f479c1939d4bb395211dc9f4091b02";
  static const String apiKey = "8fe2308f3f284a9e90a73d0915701c8f";

  // static Future<SoursesResponceModel?> getSources(String categoryId) async {
  //   var params = {
  //     "apiKey": apiKey,
  //     "category": categoryId,
  //   };
  //   Uri url = Uri.https(baseUrl, EndPoints.sources, params);

  //   http.Response response = await http.get(url);
  //   if (response.statusCode >= 200) {
  //     var json = jsonDecode(response.body);
  //     return SoursesResponceModel.fromJson(json);
  //   } else {
  //     throw Exception("Failed to load sources");
  //   }
  // }

  // static Future<ArticleModel?> getArticles(String sourceId) async {
  //   var params = {
  //     "apiKey": apiKey,
  //     "sources": sourceId,
  //   };
  //   Uri url = Uri.https(baseUrl, "/v2/top-headlines", params);

  //   http.Response response = await http.get(url);
  //   if (response.statusCode >= 200) {
  //     var json = jsonDecode(response.body);
  //     return ArticleModel.fromJson(json);
  //   } else {
  //     throw Exception("Failed to load articles");
  //   }

  static Future<SourcesModel?> getSources(String categoryId) async {
    var params = {
      "apiKey": apiKey,
      "category": categoryId,
    };
    Uri url = Uri.https(baseUrl, EndPoints.sources, params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return SourcesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load sources");
    }
  }

  static Future<ArticleModel?> getArticles(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId, // Use the correct source ID to fetch articles
    };
    Uri url = Uri.https(baseUrl, "/v2/top-headlines", params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return ArticleModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load articles. Status code: ${response.statusCode}');
      return null;
    }
  }

  static Future<ArticleModel?> searchArticles(String query) async {
    var params = {
      "apiKey": apiKey,
      "q": query,
    };
    Uri url = Uri.https(baseUrl, "/v2/everything", params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return ArticleModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to search articles");
    }
  }
}
