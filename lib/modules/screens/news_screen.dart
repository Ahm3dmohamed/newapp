import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/modules/home/manager/home_view_model.dart';
import 'package:news_app/modules/screens/details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/modules/widgets/tab_item.dart';

class NewsScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const NewsScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Check how many articles are available to render
    print(
        'Number of articles in filteredArticles: ${viewModel.filteredArticles.length}');

    return DefaultTabController(
      length: viewModel.sources.length,
      child: Column(
        children: [
          TabBar(
            labelPadding: const EdgeInsets.all(4),
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
          Expanded(
            child: viewModel.filteredArticles.isEmpty
                ? const Center(child: Text('')) // Show message if no articles
                : ListView.builder(
                    itemCount: viewModel.filteredArticles.length,
                    itemBuilder: (context, index) {
                      Articles article = viewModel.filteredArticles[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(article: article),
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
                                if (article.urlToImage != null)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: CachedNetworkImage(
                                      height: size.height * 0.25,
                                      width: size.width,
                                      fit: BoxFit.cover,
                                      imageUrl: article.urlToImage!,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/fallback_image.png'),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ??
                                            AppLocalizations.of(context)!
                                                .no_Title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            article.publishedAt
                                                    ?.substring(0, 10) ??
                                                AppLocalizations.of(context)!
                                                    .un_knownDate,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
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
                  ),
          ),
        ],
      ),
    );
  }
}
