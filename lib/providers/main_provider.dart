import 'package:flutter/material.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/source_model.dart';

class MainProvider extends ChangeNotifier {
  // int currentIndex = 0;
  // SoursesResponceModel? sourcesResponseModel;
  // ArticleModel? articleResponseModel;

  // bool isLoading = false;
  // String? errorMessage;

  // void setIndex(int index) {
  //   currentIndex = index;
  //   notifyListeners();
  // }

  // Future<void> fetchSources() async {
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     sourcesResponseModel = await ApiManager.getSources();
  //     errorMessage = null;
  //   } catch (error) {
  //     errorMessage = "Failed to load sources";
  //     sourcesResponseModel = null;
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }

  // Future<void> fetchArticles() async {
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     articleResponseModel = await ApiManager.getArticles();
  //     errorMessage = null;
  //   } catch (error) {
  //     errorMessage = "Failed to load Articles";
  //     articleResponseModel = null;
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }
}
