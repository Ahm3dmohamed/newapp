// lib/cubit/home_cubit.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/manager/api_manager.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import '../models/article_responce_model.dart';
import '../models/source_model.dart';
import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);

  List<CategoryData> categoryDataList = [
    CategoryData(
      backgrounColor: Colors.purple,
      name: "Health",
      categoryId: "health",
      imagePath: "assets/images/health.png",
    ),
    CategoryData(
      backgrounColor: Colors.red,
      name: "Sports",
      categoryId: "sports",
      imagePath: "assets/images/sports.png",
    ),
    CategoryData(
      backgrounColor: Colors.green,
      name: "Science",
      categoryId: "science",
      imagePath: "assets/images/science.png",
    ),
    CategoryData(
      backgrounColor: Colors.cyan,
      name: "Business",
      categoryId: "business",
      imagePath: "assets/images/bussines.png",
    ),
    CategoryData(
      backgrounColor: Colors.blue,
      name: "Politics",
      categoryId: "general",
      imagePath: "assets/images/politics.png",
    ),
    CategoryData(
      backgrounColor: Colors.deepPurpleAccent,
      name: "Entertainment",
      categoryId: "entertainment",
      imagePath: "assets/images/entertainment.png",
    ),
  ];
  bool _isFetchingArticles = false;

  CategoryData? categoryData;
  List<Sources> sources = [];
  List<Articles> filteredArticles = [];
  List<Articles> searchResults = [];
  ArticleModel? articleModel;
  bool isSearching = false;
  int selectedTab = 0;
  HomeCubit() : super(InitState()) {}
  int index = 0;
  // void getInitialData() async {
  //   CategoryData initialCategory = categoryDataList[selectedTab];
  //   onTabSelected(initialCategory);
  // }

  final String baseUrl = "newsapi.org";
  final String apiKey = "37f479c1939d4bb395211dc9f4091b02";

  // --- Get Sources ---
  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      final response = await http.get(Uri.https(baseUrl, "/v2/sources", {
        "apiKey": apiKey,
      }));
      // print('GetSources Response: ${response.body}');
      if (response.statusCode == 200) {
        sources =
            SourcesModel.fromJson(jsonDecode(response.body)).sources ?? [];
        emit(GetSourcesSuccessState());
        getArticles();
      } else {
        emit(GetSourcesErrorState("Failed to fetch sources."));
      }
    } catch (error) {
      emit(GetSourcesErrorState("Error: $error"));
    }
  }

  // --- Get Articles ---
  // Future<void> getArticles(String sourceId) async {
  //   emit(GetArticlesLoadingState());

  //   final params = {
  //     "apiKey": apiKey,
  //     "sources": sourceId,
  //   };

  //   try {
  //     final response =
  //         await http.get(Uri.https(baseUrl, "/v2/top-headlines", params));
  //     final articleModel = ArticleModel.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       filteredArticles = articleModel.articles ?? [];
  //       emit(GetArticlesSuccessState());
  //     } else {
  //       emit(GetArticlesErrorState("Error fetching articles."));
  //     }
  //   } catch (error) {
  //     emit(GetArticlesErrorState(error.toString()));
  //   }
  // }

  Future<void> getArticles() async {
    // if (_isFetchingArticles) return; // Prevent duplicate calls
    // _isFetchingArticles = true;

    emit(GetArticlesLoadingState());
    final params = {"apiKey": apiKey, "sources": sources[selectedTab].id};

    try {
      final response =
          await http.get(Uri.https(baseUrl, "/v2/top-headlines", params));
      // print('Articles Response: ${response.body}'); // Log the response
      final articleModel = ArticleModel.fromJson(jsonDecode(response.body));
      filteredArticles = articleModel.articles ?? [];
      if (response.statusCode != 200) {
        emit(GetArticlesErrorState(articleModel.message ?? " NO NO Broo"));
        return;
      }
      emit(GetArticlesSuccessState());
    } catch (error) {
      emit(GetArticlesErrorState("Failed to fetch articles: $error"));
    }
  }

  // --- Handle Search ---
  Future<void> searchArticles(String query) async {
    if (query.isNotEmpty) {
      isSearching = true;
      emit(CheckSearchTab());

      try {
        final articleModel = await ApiManager.getArticles(query);
        searchResults = articleModel?.articles ?? [];
      } catch (error) {
        searchResults = [];
      }
      isSearching = false;
      emit(CheckSearchTab());
    }
  }

  void clearSearch() {
    searchResults = [];
    isSearching = false;
    emit(ClearSearchTab());
  }

  // --- Tab Handling ---
  void onTabSelected(CategoryData categoryData) async {
    this.categoryData = categoryData;
    await getSources(); // Fetch sources for the selected category
    if (sources.isNotEmpty) {
      await getArticles(); // Fetch articles for the first source
    }
    emit(OnTabSelected());
  }

  void toggleSearchMode() {
    isSearching = !isSearching;
    getArticles();
    emit(OnToggleTab());
  }
}
