import 'package:flutter/material.dart';

class CustomBgWidget extends StatelessWidget {
  Widget child;
  // static const String routeName = "CustomSplash";
  CustomBgWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}
