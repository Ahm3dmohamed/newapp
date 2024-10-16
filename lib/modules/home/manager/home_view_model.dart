import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/manager/api_manager.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/sourses_responce_model.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import 'package:news_app/modules/home/manager/home_connector.dart';

class HomeViewModel extends ChangeNotifier {
  List<Sources> sources = [];
  List<Articles> articles = [];
  List<Articles> filteredArticles = [];
  List<Articles> searchResults = [];
  int selectedTab = 0;
  String searchQuery = '';
  HomeConnector? connector;
  bool isSearching = false;

  List<Articles> searchSuggestions = [];

  Timer? _debounce;

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

  CategoryData? categoryData;

  Future<void> getSources() async {
    connector?.showLoading();
    try {
      var sourceResponse =
          await ApiManager.getSources(categoryData?.categoryId ?? "");
      sources = sourceResponse?.sources ?? [];
      if (sources.isNotEmpty) {
        await getArticles(sources[selectedTab].id ?? "");
      }
    } catch (error) {
      print('Error fetching sources: $error');
    } finally {
      connector?.hideLoading();
      notifyListeners();
    }
  }

  Future<void> getArticles(String sourceId) async {
    try {
      print(
          'Fetching articles for sourceId: $sourceId'); // Debugging the source ID

      var articleResponse = await ApiManager.getArticles(sourceId);

      if (articleResponse != null && articleResponse.articles != null) {
        articles = articleResponse.articles!;
        filteredArticles = articles;
        print(
            'Articles fetched: ${articles.length}'); // Debugging the number of articles fetched
      } else {
        articles = [];
        filteredArticles = [];
        print('No articles found for this source.');
      }
    } catch (error) {
      print('Error fetching articles: $error');
    }

    notifyListeners();
  }

  void onTabSelected(int index) {
    selectedTab = index;
    print('Tab selected: $selectedTab'); // Debugging tab selection
    getArticles(sources[selectedTab].id ?? "");
    notifyListeners();
  }

  Future<void> searchArticles(String query) async {
    if (query.isNotEmpty) {
      isSearching = true;
      notifyListeners();

      try {
        // Assuming ApiManager.getArticles(query) returns an ArticleModel or null
        ArticleModel? articleModelResponse =
            await ApiManager.getArticles(query);

        if (articleModelResponse != null &&
            articleModelResponse.articles != null) {
          searchResults = articleModelResponse.articles!
              .where((article) =>
                  article.title != null &&
                  article.description != null) // Filter out null fields
              .toList();
          print('Search results fetched: ${searchResults.length}');
        } else {
          searchResults = [];
          print('No articles found for this query.');
        }
      } catch (error) {
        print('Error during search: $error');
      } finally {
        isSearching = false;
        notifyListeners();
      }
    }
  }

  // Future<void> fetchSuggestions(String query) async {
  //   searchQuery = query;

  //   if (query.isEmpty) {
  //     searchSuggestions = [];
  //     notifyListeners();
  //     return;
  //   }

  //   try {
  //     ArticleModel? response = await ApiManager.searchArticles(query);
  //     searchSuggestions = response?.articles ?? [];
  //   } catch (error) {
  //     searchSuggestions = [];
  //     print('Error fetching suggestions: $error');
  //   }

  //   notifyListeners();
  // }

  // void updateSearchQuery(String query) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     // Trigger search after 500ms debounce
  //     searchArticles(query);
  //   });
  // }

  void clearSearch() {
    searchQuery = '';
    searchResults = [];
    isSearching = false;
    _debounce?.cancel();
    notifyListeners();
  }

  void onCategoryTap(CategoryData cat) {
    categoryData = cat;
    filteredArticles = [];
    notifyListeners();
    getSources(); // Fetch sources for the selected category
  }

  void toggleSearchMode() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void startSearch() {
    isSearching = true;
    notifyListeners();
  }

  void stopSearch() {
    isSearching = false;
    notifyListeners();
  }

  String get searchResultsMessage {
    if (searchResults.isEmpty && searchQuery.isNotEmpty) {
      return "No Data";
    }
    return '';
  }

  bool get hasSearchResults => searchResults.isNotEmpty;
}
