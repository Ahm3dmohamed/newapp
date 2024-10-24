import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/drawer/custom_drawer.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/models/category_screen.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/modules/screens/search/widget/build_article_widget.dart';
import 'package:news_app/modules/screens/search/widget/custom_searchfield.dart';
import 'package:news_app/modules/widgets/tab_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomBgWidget(
      child: BlocProvider(
        create: (_) => HomeCubit(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetSourcesLoadingState ||
                state is GetArticlesLoadingState) {
              showLoadingDialog(context);
            } else if (state is GetSourcesErrorState) {
              dismissDialog(context);
              showErrorDialog(context, state.error);
            } else if (state is GetSourcesSuccessState) {
              dismissDialog(context);
            }
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.transparent,
              drawer: CustomDrawer(cubit: cubit),
              appBar: AppBar(
                title: cubit.isSearching
                    ? CustomSearchField(
                        searchController: searchController,
                        onSearch: (String query) {
                          cubit.searchArticles(query);
                        },
                      )
                    : Text(
                        cubit.categoryData?.name ??
                            AppLocalizations.of(context)!.title,
                      ),
                actions: buildAppBarActions(cubit),
              ),
              body: cubit.isSearching
                  ? BuildArticleWidget(articles: cubit.searchResults)
                  : _buildMainContent(cubit, size),
            );
          },
        ),
      ),
    );
  }

  void dismissDialog(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  Widget _buildMainContent(HomeCubit cubit, Size size) {
    if (cubit.categoryData == null) {
      return CategoryScreen(
        size: size,
        onCategoryClick: cubit.onTabSelected, // Directly pass the callback
        categoryDataList: cubit.categoryDataList,
      );
    } else {
      return Column(
        children: [
          _buildSourceTabs(cubit, size),
          Expanded(
            child: BuildArticleWidget(
              articles: cubit.filteredArticles,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSourceTabs(HomeCubit cubit, Size size) {
    return SizedBox(
      height: size.height * .09,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cubit.sources.length,
        itemBuilder: (context, index) {
          final source = cubit.sources[index];
          return GestureDetector(
            onTap: () {
              if (cubit.state is! GetArticlesLoadingState &&
                  source.id != null) {
                cubit.getArticles(); // Fetch articles when a source is tapped
              }
            },
            child: TabItem(
              source: source,
              isSelected: cubit.selectedTab == index,
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildAppBarActions(HomeCubit cubit) {
    if (cubit.isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
            cubit.clearSearch();
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: cubit.toggleSearchMode,
        ),
      ];
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void showErrorDialog(BuildContext context, String error) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
