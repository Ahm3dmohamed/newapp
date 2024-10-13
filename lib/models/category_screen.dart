import 'package:flutter/material.dart';
import 'package:news_app/modules/widgets/category_data.dart';
import 'package:news_app/modules/widgets/category_items_widget.dart';

class CategoryScreen extends StatelessWidget {
  final Function(CategoryData) onCategoryClick;
  final List<CategoryData> categoryDataList;
  final Size size;

  const CategoryScreen({
    super.key,
    required this.size,
    required this.onCategoryClick,
    required this.categoryDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.width * 0.06,
            left: size.width * 0.05,
          ),
          child: const Text(
            "Pick Your Categories\nof Interest",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
            // padding: const EdgeInsets.all(0.0),
            itemCount: categoryDataList.length,
            itemBuilder: (context, index) {
              return CategoryItemsWidget(
                categoryData: categoryDataList[index],
                index: index,
                onTap: (categoryData) {
                  onCategoryClick(categoryData);
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: .2,
              childAspectRatio: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
