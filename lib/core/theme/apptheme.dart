import 'package:flutter/material.dart';
import 'package:news_app/core/theme/appcolor.dart';

class Apptheme {
  static ThemeData lightThem = ThemeData(
      textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.green,
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: 88,
        titleTextStyle: const TextStyle(fontSize: 22, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white, size: 34),
        centerTitle: true,
        foregroundColor: Appcolor.defualtColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44))),
        backgroundColor: Appcolor.appbarColor,
      ));
}
