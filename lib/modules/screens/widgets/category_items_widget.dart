import 'package:flutter/material.dart';
import 'package:news_app/modules/screens/source_data_screen.dart';
import 'package:news_app/modules/screens/widgets/category_data.dart';

class CategoryItemsWidget extends StatelessWidget {
  final CategoryData categoryData;
  int index;
  CategoryItemsWidget(this.categoryData, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsScreen(),
              ));
        },
        child: Container(
            height: size.height * 0.3,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomRight: index % 2 != 0
                      ? const Radius.circular(16)
                      : const Radius.elliptical(0, 2),
                  bottomLeft: index % 2 == 0
                      ? const Radius.circular(16)
                      : const Radius.elliptical(0, 2),
                ),
                color: categoryData.backgrounColor),
            child: Column(
              children: [
                Expanded(
                    child: Image.asset(
                  categoryData.imagePath,
                )),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.width * .02,
                  ),
                  child: Text(
                    categoryData.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
