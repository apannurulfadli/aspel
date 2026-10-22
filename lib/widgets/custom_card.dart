import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget content;
  final Color headerColor;

  const CustomCard({
    super.key,
    required this.title,
    required this.content,
    this.headerColor = const Color(0xFF334d80),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: headerColor,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          content,
        ],
      ),
    );
  }
}
