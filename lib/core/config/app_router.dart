// import 'package:flutter/material.dart';
// import 'package:news_app/core/config/page_routes_name.dart';
// import 'package:news_app/modules/screens/home.dart';
// import 'package:news_app/modules/screens/news_screen.dart';
// import 'package:news_app/modules/screens/settings.dart';
// import 'package:news_app/modules/widgets/category_data.dart';

// class AppRouter {
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     final args = settings.arguments;

//     switch (settings.name) {
//       case PageRoutesName.homeScreen:
//         return MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//           settings: settings,
//         );

//       case PageRoutesName.newsScreen:
//         if (args is CategoryData) {
//           return MaterialPageRoute(
//             builder: (context) => NewsScreen(),
//             settings: settings,
//           );
//         }
//         return _errorRoute();

//       case PageRoutesName.setting:
//         return MaterialPageRoute(
//           builder: (context) => const Settings(),
//           settings: settings,
//         );

//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(
//       builder: (context) => const Scaffold(
//         body: Center(
//           child: Text("There is no route for this screen!"),
//         ),
//       ),
//     );
//   }
// }
