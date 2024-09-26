import 'package:flutter/material.dart';
import 'package:news_app/core/config/app_router.dart';
import 'package:news_app/core/config/page_routes_name.dart';
import 'package:news_app/core/theme/apptheme.dart';
import 'package:news_app/modules/providers/main_provider.dart';
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
      initialRoute: PageRoutesName.homeScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
