import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  IconData icon;
  String txt;
  CustomDrawer({required this.icon, required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.width * .04,
        left: size.width * .04,
      ),
      child: ListTile(
        title: Row(
          children: [
            Icon(
              color: Colors.black,
              icon,
              size: 40,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              txt,
            ),
          ],
        ),
        titleTextStyle: const TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
