import 'package:flutter/material.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import 'package:news_app/modules/widgets/category_items_widget.dart';

class CategoryScreen extends StatelessWidget {
  final Function(CategoryData) onCategoryClick;
  final List<CategoryData> categoryDataList;
  final Size size;

  CategoryScreen({
    super.key,
    required this.size,
    required this.onCategoryClick,
    required this.categoryDataList, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: size.width * .06, left: size.width * .05),
          child: const Text("Pick Your Categories \n of interest"),
        ),
        Expanded(
          child: GridView.builder(
            itemCount: categoryDataList.length, // Use the passed list
            itemBuilder: (context, index) => CategoryItemsWidget(
              categoryData: categoryDataList[index],
              index: index,
              onTap: (categoryData) {
                onCategoryClick(categoryDataList[index]);
              },
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: .09,
              mainAxisSpacing: .5,
              childAspectRatio: 90 / 110,
            ),
          ),
        )
      ],
    );
  }
}
