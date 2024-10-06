import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization
import 'package:news_app/manager/api_manager.dart';
import 'package:news_app/models/article_responce_model.dart';
import 'package:news_app/models/sourses_responce_model.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/modules/screens/details_screen.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import 'package:news_app/modules/widgets/tab_item.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatefulWidget {
  static const String routeName = "NewsScreen";

  CategoryData? categoryData;

  NewsScreen({super.key, this.categoryData});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<SoursesResponceModel?>(
          future: ApiManager.getSources(widget.categoryData!.categoryId),
          builder: (BuildContext context,
              AsyncSnapshot<SoursesResponceModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerSkeleton(size);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(AppLocalizations.of(context)!
                    .error_Data), // Localized error message
              );
            } else if (!snapshot.hasData || snapshot.data?.sources == null) {
              return Center(
                child: Text(AppLocalizations.of(context)!
                    .no_Data), // Localized no data message
              );
            } else {
              List<Sources> sources = snapshot.data!.sources!;

              return DefaultTabController(
                length: sources.length,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TabBar(
                        labelPadding: const EdgeInsets.all(4),
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        onTap: (value) {
                          selectedIndex = value;
                          setState(() {});
                        },
                        tabs: sources
                            .map((source) => TabItem(
                                  source: source,
                                  isSelected:
                                      selectedIndex == sources.indexOf(source),
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<ArticleModel?>(
                        future: ApiManager.getArticles(
                            sources[selectedIndex].id ?? ''),
                        builder: (BuildContext context,
                            AsyncSnapshot<ArticleModel?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildShimmerSkeleton(size);
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .error_Data), // Localized error message
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data?.articles == null) {
                            return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .no_Articles), // Localized no articles message
                            );
                          } else {
                            List<Articles> articles = snapshot.data!.articles!;

                            return ListView.builder(
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                Articles article = articles[index];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (article.urlToImage != null)
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
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
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
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
                                                      AppLocalizations.of(
                                                              context)!
                                                          .no_Title, // Localized title
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // const SizedBox(height: 8),
                                                // Text(
                                                //   article.description ??
                                                //       AppLocalizations.of(
                                                //               context)!
                                                //           .no_Description, // Localized description
                                                //   style: const TextStyle(
                                                //       fontSize: 14),
                                                // ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      article.publishedAt
                                                              ?.substring(
                                                                  0, 10) ??
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .un_knownDate, // Localized date
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
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Shimmer loading skeleton
  Widget _buildShimmerSkeleton(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: size.width,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.7,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width * 0.9,
                          height: 14,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width * 0.3,
                          height: 12,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
