import 'package:flutter/material.dart';
import 'package:news_app/manager/api_manager.dart';
import 'package:news_app/models/sourses_responce_model.dart';
import 'package:news_app/modules/layouts/splash/custom_splash.dart';
import 'package:news_app/modules/screens/article_data_screen.dart';
import 'package:news_app/modules/screens/widgets/tab_item.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "News App",
          ),
        ),
        body: Column(
          children: [
            FutureBuilder<SoursesResponceModel?>(
              future: ApiManager.getSources(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error in Data"));
                } else if (!snapshot.hasData || snapshot.data.sources == null) {
                  return const Center(child: Text("No data available"));
                } else {
                  List<Sources> sources = snapshot.data.sources;

                  return Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: DefaultTabController(
                      initialIndex: currentIndex,
                      length: sources.length,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            isScrollable: true,
                            onTap: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            tabs: sources
                                .map(
                                  (e) => TabItem(
                                    source: e,
                                    isSelected:
                                        sources.indexOf(e) == currentIndex,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: const ArticleDataScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
