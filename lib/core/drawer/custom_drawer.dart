import 'package:flutter/material.dart';
import 'package:news_app/core/drawer/custom_list_tiledart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Adjust if needed

class CustomDrawer extends StatelessWidget {
  final HomeCubit cubit;

  const CustomDrawer({required this.cubit});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * .18,
          title: Text(AppLocalizations.of(context)!.title),
        ),
        body: Column(
          children: [
            CustomListTile(
              onTap: () {
                cubit.clearSearch();
                cubit.categoryData = null;
                Navigator.pop(context);
              },
              icon: Icons.list_rounded,
              txt: AppLocalizations.of(context)!.category,
            ),
            CustomListTile(
              icon: Icons.settings,
              txt: AppLocalizations.of(context)!.settings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
