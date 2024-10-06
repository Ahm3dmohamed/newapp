import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/category_screen.dart';
import 'package:news_app/modules/screens/news_screen.dart';
import 'package:news_app/modules/screens/settings.dart';
import 'package:news_app/modules/screens/search/article_card_widget.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/manager/api_manager.dart';
import 'package:news_app/core/drawer/custom_list_tiledart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryData? categoryData;
  List<CategoryData> categoryDataList = [
    CategoryData(
        backgrounColor: Colors.red,
        name: "Sports",
        categoryId: "sports",
        imagePath: "assets/images/ball.png"),
    CategoryData(
        backgrounColor: Colors.cyan,
        name: "Business",
        categoryId: "business",
        imagePath: "assets/images/bussines.png"), // Corrected spelling
    CategoryData(
        backgrounColor: Colors.green,
        name: "Science",
        categoryId: "science",
        imagePath: "assets/images/science.png"),
    CategoryData(
        backgrounColor: Colors.blue,
        name: "Politics",
        categoryId: "general",
        imagePath: "assets/images/politics.png"), // Corrected to lowercase
    CategoryData(
        backgrounColor: Colors.purple,
        name: "Health",
        categoryId: "health",
        imagePath: "assets/images/health.png"),
    CategoryData(
        backgrounColor: Colors.orange,
        name: "Entertainment",
        categoryId: "technology",
        imagePath: "assets/images/environment.png"),
  ];

  List<Articles>? searchResults;
  bool isSearching = false;
  String searchQuery = '';

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: buildDrawer(size, context),
        appBar: AppBar(
          title: isSearching
              ? buildSearchField()
              : Text(categoryData?.name ??
                  AppLocalizations.of(context)!.title), // Localized title
          actions: buildAppBarActions(),
        ),
        body: isSearching
            ? buildSearchResults()
            : categoryData == null
                ? CategoryScreen(
                    size: size,
                    onCategoryClick: onCategoryTap,
                    categoryDataList: categoryDataList,
                  )
                : NewsScreen(
                    categoryData: categoryData,
                  ),
      ),
    );
  }

  // Drawer method
  Drawer buildDrawer(Size size, BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * .18,
          title: Text(AppLocalizations.of(context)!.title), // Localized title
        ),
        body: Column(
          children: [
            CustomListTile(
              onTap: popDrawer,
              icon: Icons.list_rounded,
              txt: AppLocalizations.of(context)!
                  .category, // Localized categories
            ),
            CustomListTile(
              icon: Icons.settings,
              txt: (AppLocalizations.of(context)!.settings),
              // Localized settings
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Search Bar method
  TextField buildSearchField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.search, // Localized search hint
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white60),
      ),
      style: const TextStyle(color: Colors.white),
      onSubmitted: searchArticles, // Trigger search on submission
    );
  }

  // AppBar Actions method
  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isSearching = false;
              searchController.clear();
              searchQuery = '';
              searchResults = null; // Clear search results
            });
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
        ),
      ];
    }
  }

  Widget buildSearchResults() {
    if (searchResults == null) {
      return Center(
        child: Text(
            AppLocalizations.of(context)!.search), // Localized search prompt
      );
    }

    if (searchResults!.isEmpty) {
      return const Center(
        child: Text("No Article Found"),
      );
    }

    return ListView.builder(
      itemCount: searchResults?.length ?? 0,
      itemBuilder: (context, index) {
        Articles article = searchResults![index];
        return ArticleCardWidget(article: article);
      },
    );
  }

  // Category Tap method
  void onCategoryTap(CategoryData selectedCategoryData) {
    setState(() {
      categoryData = selectedCategoryData;
      searchResults = null;
    });
  }

  // Drawer Pop method
  void popDrawer() {
    setState(() {
      categoryData = null;
      Navigator.pop(context);
    });
  }

  void searchArticles(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });

      ArticleModel? articleModelResponse = await ApiManager.getArticles(query);

      setState(() {
        isSearching = false;
        searchResults =
            filterValidArticles(articleModelResponse?.articles ?? []);
      });
    }
  }

  List<Articles> filterValidArticles(List<Articles> articles) {
    return articles.where((article) {
      return article.title != null &&
          article.description != null &&
          article.publishedAt != null;
    }).toList();
  }
}
