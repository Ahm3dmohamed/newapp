import 'package:flutter/material.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';

class Settings extends StatefulWidget {
  static const String routeName = "Settings";

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
    ));
  }
}
