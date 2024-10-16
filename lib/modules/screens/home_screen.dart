import 'package:flutter/material.dart';
import 'package:news_app/core/drawer/custom_drawer.dart';
import 'package:news_app/models/category_screen.dart';
import 'package:news_app/modules/home/manager/home_connector.dart';
import 'package:news_app/modules/home/manager/home_view_model.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/modules/screens/search/widget/build_article_widget.dart';
import 'package:news_app/modules/screens/search/widget/custom_searchfield.dart';
import 'package:news_app/modules/widgets/tab_item.dart';
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
                    ? BuildSearchField(
                        searchController: searchController,
                        context: context,
                        viewModel: viewModel)
                    : Text(viewModel.categoryData?.name ??
                        AppLocalizations.of(context)!.title),
                actions: buildAppBarActions(viewModel),
              ),
              body: viewModel.isSearching
                  ? BuildArticleWidget(articles: viewModel.searchResults)
                  : _buildMainContent(viewModel, size),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(HomeViewModel viewModel, Size size) {
    if (viewModel.categoryData == null) {
      return CategoryScreen(
        size: size,
        onCategoryClick: viewModel.onCategoryTap,
        categoryDataList: viewModel.categoryDataList,
      );
    } else {
      return Column(
        children: [
          _buildSourceTabs(viewModel, size), // Source tabs at the top
          Expanded(
            // This ensures the article list takes the remaining space
            child: BuildArticleWidget(
              articles: viewModel.filteredArticles,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSourceTabs(HomeViewModel viewModel, Size size) {
    return SizedBox(
      height: size.height * .09, // Adjust height for the tabs
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.sources.length,
        itemBuilder: (context, index) {
          final source = viewModel.sources[index];
          return GestureDetector(
            onTap: () {
              viewModel.onTabSelected(index);
            },
            child: DefaultTabController(
              length: viewModel.sources.length,
              child: TabBar(
                indicatorColor: Colors.transparent,
                isScrollable: true,
                onTap: viewModel.onTabSelected,
                tabs: viewModel.sources
                    .map((source) => TabItem(
                          source: source,
                          isSelected: viewModel.selectedTab ==
                              viewModel.sources.indexOf(source),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
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
