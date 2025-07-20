import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';

class CircularPathPainter extends CustomPainter {
  final double diameter;
  final double animationValue;
  final double pathRadius; // <--- ADD THIS NEW PARAMETER

  CircularPathPainter({
    required this.diameter,
    required this.animationValue,
    required this.pathRadius, // <--- REQUIRE IT IN THE CONSTRUCTOR
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.accentOrange // Your accent color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Path thickness

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Use the passed pathRadius for drawing the arc
    Rect rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: pathRadius); // <--- USE pathRadius HERE

    // These angles should match what you have in AnimatedCircularMenu for consistency
    double startAnglePath = -pi * 0.75;
    double sweepAnglePath = pi * 1.5;

    canvas.drawArc(rect, startAnglePath, sweepAnglePath * animationValue, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    CircularPathPainter oldPainter = oldDelegate as CircularPathPainter;
    // Update shouldRepaint to include the new pathRadius parameter
    return oldPainter.animationValue != animationValue ||
        oldPainter.diameter != diameter ||
        oldPainter.pathRadius != pathRadius; // <--- INCLUDE pathRadius HERE
  }
}

