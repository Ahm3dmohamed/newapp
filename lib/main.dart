import 'package:flutter/material.dart';
import 'package:news_app/core/theme/apptheme.dart';
import 'package:news_app/modules/providers/main_provider.dart';
import 'package:news_app/modules/screens/home.dart';
import 'package:news_app/modules/screens/news_screen.dart';
import 'package:news_app/modules/screens/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Apptheme.lightThem,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      // onGenerateRoute: AppRouter.onGenerateRoute,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        NewsScreen.routeName: (_) => NewsScreen(),
        Settings.routeName: (_) => const Settings(),
      },
    );
  }
}
