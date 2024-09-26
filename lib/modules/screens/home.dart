import 'package:flutter/material.dart';

import 'package:news_app/modules/layouts/splash/custom_splash.dart';
import 'package:news_app/modules/screens/settings.dart';
import 'package:news_app/modules/screens/widgets/category_data.dart';
import 'package:news_app/modules/screens/widgets/category_items_widget.dart';
import 'package:news_app/modules/screens/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<CategoryData> categoruDataList = [
    CategoryData(
        backgrounColor: Colors.red,
        name: "Sports",
        categoryId: "sports",
        imagePath: "assets/images/ball.png"),
    CategoryData(
        backgrounColor: Colors.cyan,
        name: "Bussines",
        categoryId: "bussines",
        imagePath: "assets/images/bussines.png"),
    CategoryData(
        backgrounColor: Colors.green,
        name: "science",
        categoryId: "science",
        imagePath: "assets/images/science.png"),
    CategoryData(
        backgrounColor: Colors.blue,
        name: "politics",
        categoryId: "politics",
        imagePath: "assets/images/Politics.png"),
    CategoryData(
        backgrounColor: Colors.purple,
        name: "health",
        categoryId: "health",
        imagePath: "assets/images/health.png"),
    CategoryData(
        backgrounColor: Colors.orange,
        name: "environment",
        categoryId: "environment",
        imagePath: "assets/images/environment.png")
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomSplash(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: size.height * .18,
              title: const Text(
                "News App",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomDrawer(
                        icon: Icons.list_rounded, txt: "Categories")),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ));
                    },
                    child: CustomDrawer(icon: Icons.settings, txt: "Settings")),
              ],
            )),
      ),
      appBar: AppBar(
        title: const Text(
          "News App",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: size.width * .06, left: size.width * .05),
            child: const Text("Pick Your Categories \n of interest"),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: categoruDataList.length,
              itemBuilder: (context, index) => CategoryItemsWidget(
                categoruDataList[index],
                index,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: .09,
                  mainAxisSpacing: .05,
                  childAspectRatio: 0.73),
            ),
          )
        ],
      ),
    ));
  }
}
