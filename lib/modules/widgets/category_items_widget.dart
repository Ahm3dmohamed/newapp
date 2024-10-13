import 'package:flutter/material.dart';
import 'package:news_app/modules/widgets/category_data.dart';

class CategoryItemsWidget extends StatelessWidget {
  final CategoryData categoryData;
  void Function(CategoryData) onTap;
  int index;
  CategoryItemsWidget({
    required this.onTap,
    required this.categoryData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(24),
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
        child: InkWell(
          onTap: () {
            onTap(categoryData);
          },
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(categoryData.imagePath),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: size.width * .02,
                ),
                child: Text(
                  categoryData.name,
                  style: const TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
