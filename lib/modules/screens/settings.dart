import 'package:flutter/material.dart';
import 'package:news_app/modules/layouts/splash/custom_splash.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
    ));
  }
}
