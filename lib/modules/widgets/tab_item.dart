import 'package:flutter/material.dart';
import 'package:news_app/models/sourses_responce_model.dart';

class TabItem extends StatefulWidget {
  final Sources source;
  final bool isSelected;

  TabItem({required this.source, required this.isSelected, super.key});

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green),
      ),
      child: Text(
        widget.source.name ?? " ", // Ensure there's always a string to display
        style: TextStyle(
          color: widget.isSelected ? Colors.white : Colors.green,
        ),
      ),
    );
  }
}
