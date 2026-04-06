import 'package:flutter/material.dart';

class IconTextChip extends StatelessWidget {
  final IconData? icon;
  final String image;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const IconTextChip({
    super.key,
    required this.icon,
    required this.image,
    required this.text,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: iconColor,
              )
            else if (image != null)
              Image.asset(
                image!,
                height: 16,
                width: 16,
                fit: BoxFit.contain,
              ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}