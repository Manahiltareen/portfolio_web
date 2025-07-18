// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:portfolio_web/core/theme/app_colors.dart';
//
// class CircularPathPainter extends CustomPainter {
//   final double diameter;
//   final double animationValue; // New parameter to control drawing progress
//
//   CircularPathPainter({required this.diameter, required this.animationValue});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.accentOrange
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = diameter / 2 + 0;
//
//     double startAngle = -pi * 0.75;
//     double sweepAngle = pi * 1.5;
//
//     // Draw the main arc based on animationValue
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle, // Start angle is fixed
//       sweepAngle * animationValue, // Sweep angle progresses with animation
//       false,
//       paint,
//     );
//
//     // Draw dots along the path based on animationValue
//     final dotPaint = Paint()..color = AppColors.accentOrange;
//     final numberOfDots = 6;
//     for (int i = 0; i < numberOfDots; i++) {
//       // Only draw the dot if its position is "reached" by the current animation progress
//       if (i / (numberOfDots - 1) <= animationValue) {
//         double angle = startAngle + (sweepAngle / (numberOfDots - 1)) * i;
//         final dotX = center.dx + radius * cos(angle);
//         final dotY = center.dy + radius * sin(angle);
//         canvas.drawCircle(Offset(dotX, dotY), 4, dotPaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CircularPathPainter oldDelegate) {
//     // Repaint if diameter or animationValue changes
//     return oldDelegate.diameter != diameter || oldDelegate.animationValue != animationValue;
//   }
// }
import 'dart:math'; // Make sure you import dart:math
import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/app_colors.dart'; // Make sure this path is correct

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