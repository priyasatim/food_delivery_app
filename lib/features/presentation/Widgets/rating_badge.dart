import 'package:flutter/material.dart';

import '../../../core/common/app_colors.dart';



class RatingBadge extends StatelessWidget {
  final String rating;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double iconSize;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const RatingBadge({
    super.key,
    required this.rating,
    this.backgroundColor = AppColors.extraDarkGreen,
    this.textColor = Colors.white,
    this.fontSize = 11,
    this.iconSize = 12,
    this.padding =
    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: textColor, size: iconSize),
          const SizedBox(width: 2),
          Text(
            rating,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}