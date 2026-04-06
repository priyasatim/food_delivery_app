import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/common/app_colors.dart';

class RadioItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const RadioItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedBg : Colors.white,
        ),
        child: Row(
          children: [

            /// Text (left side)
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.textPrimary : Colors.black,
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Radio circle (right side)
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.textPrimary : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}