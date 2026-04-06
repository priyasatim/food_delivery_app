import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryInfoRow extends StatelessWidget {
  final IconData? icon;
  final String text; // main text
  final String? subText; // secondary text
  final bool subpart; // show subText or not
  final double iconSize;
  final Color iconColor;
  final double fontSize;
  final Color fontColor;
  final double subFontSize;
  final Color subFontColor;

  const DeliveryInfoRow({
    super.key,
    this.icon,
    required this.text,
    this.subText,
    this.subpart = false,
    this.iconSize = 16,
    this.iconColor = Colors.grey,
    this.fontSize = 12,
    this.fontColor = Colors.black,
    this.subFontSize = 10,
    this.subFontColor = Colors.black45,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon or space
        icon != null
            ? Icon(icon, size: iconSize, color: iconColor)
            : SizedBox(width: iconSize),
        const SizedBox(width: 4),

        // Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: fontSize, color: fontColor),
              ),
              if (subpart && subText != null) ...[
                const SizedBox(height: 2),
                Text(
                  subText!,
                  style: TextStyle(fontSize: subFontSize, color: subFontColor),
                ),
              ],
            ],
          ),
        ),

        // Arrow
        Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 20,
        )

      ],
    );
  }
}