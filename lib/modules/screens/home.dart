import 'package:flutter/material.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/category_screen.dart';
import 'package:news_app/modules/screens/details_screen.dart';
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
        name: "Bussines",
        categoryId: "business",
        imagePath: "assets/images/bussines.png"),
    CategoryData(
        backgrounColor: Colors.green,
        name: "science",
        categoryId: "science",
        imagePath: "assets/images/science.png"),
    CategoryData(
        backgrounColor: Colors.blue,
        name: "politics",
        categoryId: "general",
        imagePath: "assets/images/Politics.png"),
    CategoryData(
        backgrounColor: Colors.purple,
        name: "health",
        categoryId: "health",
        imagePath: "assets/images/health.png"),
    CategoryData(
        backgrounColor: Colors.orange,
        name: "environment",
        categoryId: "entertainment",
        imagePath: "assets/images/environment.png")
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
        drawer: buildDrawer(size),
        appBar: AppBar(
          title: isSearching
              ? buildSearchField()
              : Text(categoryData?.name ?? "News App"),
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
  Drawer buildDrawer(Size size) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * .18,
          title: const Text(
            "News App",
            // style: TextStyle(
            //   fontSize: 22,
            //   fontWeight: FontWeight.bold,
            //   color: Colors.white,
            // ),
          ),
        ),
        body: Column(
          children: [
            CustomListTile(
              onTap: popDrawer,
              icon: Icons.list_rounded,
              txt: "Categories",
            ),
            CustomListTile(
              icon: Icons.settings,
              txt: "Settings",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                  (route) => false,
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
      decoration: const InputDecoration(
        hintText: 'Search articles...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white60),
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

  // Method for displaying search results
  Widget buildSearchResults() {
    if (searchResults == null) {
      return const Center(
        child: Text("Search for articles..."),
      );
    }

    return ListView.builder(
      itemCount: searchResults?.length ?? 0,
      itemBuilder: (context, index) {
        Articles article = searchResults![index];
        return buildArticleWidget(article);
      },
    );
  }

  // Article Widget method
  Widget buildArticleWidget(Articles article) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(article: article),
          ),
        );
      },
      child: ArticleCardWidget(),
    );
  }

  // Category Tap method
  void onCategoryTap(CategoryData selectedCategoryData) {
    setState(() {
      categoryData = selectedCategoryData;
      searchResults = null; // Reset search results when category changes
    });
  }

  // Drawer Pop method
  void popDrawer() {
    setState(() {
      categoryData = null;
      Navigator.pop(context);
    });
  }

  // Search Articles method
  void searchArticles(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });

      ArticleModel? articleModelResponse = await ApiManager.getArticles(query);

      setState(() {
        isSearching = false;
        searchResults = articleModelResponse?.articles;
      });
    }
  }
}
