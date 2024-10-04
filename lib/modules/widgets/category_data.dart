import 'package:flutter/material.dart';

class CategoryData {
  final String categoryId;
  final String name;
  final Color backgrounColor;
  final String imagePath;

  CategoryData({
    required this.backgrounColor,
    required this.name,
    required this.categoryId,
    required this.imagePath,
  });
}
