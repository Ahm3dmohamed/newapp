// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:news_app/modules/layouts/splash/custom_splash.dart';
// import 'package:news_app/modules/screens/home.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(seconds: 1),
//       () {
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomSplash(
//       child: Container(
//           decoration: const BoxDecoration(
//               image:
//                   DecorationImage(image: AssetImage("assets/images/logo.png"))),
//           child: const Scaffold(
//             backgroundColor: Colors.transparent,
//           )),
//     );
//   }
// }
