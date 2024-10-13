import 'package:flutter/material.dart';
import 'package:news_app/core/drawer/custom_drawer.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/category_screen.dart';
import 'package:news_app/modules/home/manager/home_connector.dart';
import 'package:news_app/modules/home/manager/home_view_model.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/modules/screens/details_screen.dart';
import 'package:news_app/modules/screens/news_screen.dart';
import 'package:news_app/modules/screens/search/article_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeConnector {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomBgWidget(
      child: ChangeNotifierProvider(
        create: (_) => HomeViewModel()..connector = this,
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              drawer: CustomDrawer(viewModel: viewModel),
              appBar: AppBar(
                title: viewModel.isSearching
                    ? buildSearchField(viewModel)
                    : Text(viewModel.categoryData?.name ??
                        AppLocalizations.of(context)!.title),
                actions: buildAppBarActions(viewModel),
              ),
              body: viewModel.isSearching
                  ? buildArticleWidget(
                      viewModel.searchResults) // Show search results
                  : _buildMainContent(
                      viewModel, size), // Show category articles
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(HomeViewModel viewModel, Size size) {
    return viewModel.categoryData == null
        ? CategoryScreen(
            size: size,
            onCategoryClick: viewModel.onCategoryTap,
            categoryDataList: viewModel.categoryDataList,
          )
        : buildArticleWidget(viewModel
            .filteredArticles); // Show filtered articles for the selected category
  }

  TextField buildSearchField(HomeViewModel viewModel) {
    return TextField(
        controller: searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.white60),
        ),
        style: const TextStyle(color: Colors.white),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            viewModel.searchArticles(query);
          }
        });
  }

  List<Widget> buildAppBarActions(HomeViewModel viewModel) {
    if (viewModel.isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
            viewModel.clearSearch();
            viewModel.stopSearch();
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            viewModel.startSearch(); // Start search mode
          },
        ),
      ];
    }
  }

  Widget buildArticleWidget(List<Articles> articles) {
    if (articles.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    return ListView.builder(
      itemCount: articles.length, // Use the length of the provided article list
      itemBuilder: (context, index) {
        final article = articles[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(article: article),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handling null for article.urlToImage
                  if (article.urlToImage != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        article.urlToImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const SizedBox(
                      height: 200,
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handling null for article.title
                        Text(
                          article.title ?? "No Title",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.description ?? "No Description",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Handling null for article.publishedAt
                            Text(
                              article.publishedAt?.substring(0, 10) ??
                                  "Unknown Date",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const Icon(Icons.more_vert),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void showLoading() {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }
}
