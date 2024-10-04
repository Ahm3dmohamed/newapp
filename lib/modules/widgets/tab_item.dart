import 'package:flutter/material.dart';
import 'package:news_app/models/sourses_responce_model.dart';

class TabItem extends StatelessWidget {
  Sources source;
  bool isSelected;
  TabItem({required this.source, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.green)),
      child: Text(
        source.name ?? " ",
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.green,
        ),
      ),
    );
  }
}
