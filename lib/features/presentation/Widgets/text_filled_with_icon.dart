import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final VoidCallback? onSuffixTap;

  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,

        /// PREFIX ICON
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 16)
            : null,

        /// SUFFIX ICON (optional click)
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Icon(suffixIcon, size: 16),
        )
            : null,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}