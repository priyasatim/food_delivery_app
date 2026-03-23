import 'package:flutter/material.dart';

class AppTextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double fontSize;
  final Color color;
  final EdgeInsetsGeometry padding;

  const AppTextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize = 12,
    this.color = const Color(0xFFE23744),
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            height: 1,
          ),
        ),
      ),
    );
  }
}