import 'package:flutter/material.dart';

class AppCircleIcon extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;

  final double radius;
  final double iconSize;
  final double padding;

  final Color backgroundColor;
  final Color iconColor;

  const AppCircleIcon({
    super.key,
    this.imagePath,
    this.icon,
    this.radius = 20,
    this.iconSize = 20,
    required this.padding,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (imagePath != null && imagePath!.isNotEmpty) {
      child = Image.asset(
        imagePath!,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
      );
    } else if (icon != null) {
      child = Icon(
        icon,
        size: iconSize,
        color: iconColor,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child ?? const SizedBox(), // fallback
      ),
    );
  }
}