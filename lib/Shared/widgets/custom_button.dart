

import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double? fontSize;
  final BorderSide? border; // Added border property

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.accentOrange,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.fontSize,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: border ?? BorderSide.none, // Apply border if provided
        ),
        elevation: 0, // No shadow by default, matching flat design
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}