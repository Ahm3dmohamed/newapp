import 'package:flutter/material.dart';
import 'package:news_app/core/config/page_routes_name.dart';
import 'package:news_app/modules/layouts/splash/splash_screen.dart';
import 'package:news_app/modules/screens/article_data_screen.dart';
import 'package:news_app/modules/screens/home.dart';
import 'package:news_app/modules/screens/source_data_screen.dart';
import 'package:news_app/modules/screens/settings.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case PageRoutesName.splashName:
      //   return MaterialPageRoute(
      //       builder: (context) => SplashScreen(), settings: settings);
      case PageRoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(), settings: settings);
      case PageRoutesName.newsScreen:
        return MaterialPageRoute(
            builder: (context) => const NewsScreen(), settings: settings);
      case PageRoutesName.setting:
        return MaterialPageRoute(
            builder: (context) => Settings(), settings: settings);

      case PageRoutesName.articleScreen:
        return MaterialPageRoute(
          builder: (context) => const ArticleDataScreen(),
        );

      default:
        return MaterialPageRoute(
            builder: (context) =>
                const Center(child: Text("Ther Is No Routes Yaa Broo")),
            settings: settings);
    }
  }
}
