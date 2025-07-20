
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/View/Hero_section/presentation/Common_widgets/dashed_circle_painter.dart';


import 'package:portfolio_web/core/constants/hero_data.dart';
import 'package:portfolio_web/core/manager/Scroll_manager.dart';


import '../../../../core/theme/app_colors.dart';

Widget buildSaritaText(double fontSize) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "I'M",
        style: TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.bold,
          color:Colors.white,
          // color: AppColors.accentYellow,
          decoration: TextDecoration.none,
        ),
      ),
      const SizedBox(width: 10),
      Stack(
        children: [
          // Outline Text
          Text(
            "MANAHIL",
            style: TextStyle(

              fontSize: 70,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.5
                ..color = AppColors.accentOrange, // Orange outline
            ),
          ),
          // Transparent Text (to maintain layout space for outline)
          Text(
            "MANAHIL",
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Colors.transparent,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    ],
  );
}


// Common widget for circular navigation around the image
// Widget buildCircularNavigation(double diameter) {
//   return SizedBox(
//     width: diameter + 0, // Make the canvas slightly larger than the image
//     height: diameter + 0,
//     child: CustomPaint(
//       painter: CircularPathPainter(diameter: diameter),
//       child: Stack(
//         children: [
//           // List of icon data
//           buildCircularIcons(diameter),
//         ],
//       ),
//     ),
//   );
// }




// lib/View/Hero_section/presentation/Widgets/animated_circular_menu.dart
// ⭐ Import the manager

// Your CircularPathPainter class (make sure it's in a separate file or defined here)
// For this example, assuming it's correctly defined and imported.
class CircularPathPainter extends CustomPainter {
  final double diameter;
  final double animationValue;
  final double pathRadius;

  CircularPathPainter({
    required this.diameter,
    required this.animationValue,
    required this.pathRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.accentOrange.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    Rect rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: pathRadius);

    double startAnglePath = -pi * 0.75;
    double sweepAnglePath = pi * 1.5;

    canvas.drawArc(rect, startAnglePath, sweepAnglePath * animationValue, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    CircularPathPainter oldPainter = oldDelegate as CircularPathPainter;
    return oldPainter.animationValue != animationValue ||
        oldPainter.diameter != diameter ||
        oldPainter.pathRadius != pathRadius;
  }
}


class AnimatedCircularMenu extends StatefulWidget {
  final double diameter;
  // ⭐ New: Pass the ScrollManager instance
  final ScrollManager scrollManager;

  const AnimatedCircularMenu({
    super.key,
    required this.diameter,
    required this.scrollManager, // ⭐ Require the ScrollManager
  });

  @override
  State<AnimatedCircularMenu> createState() => _AnimatedCircularMenuState();
}

class _AnimatedCircularMenuState extends State<AnimatedCircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // IMPORTANT: The order here must match the _sectionKeys order in ScrollManager
  final List<Map<String, dynamic>> icons = [
    {'icon': Icons.home, 'label': 'Home'},         // index 0 -> homeSectionKey
    {'icon': Icons.person, 'label': 'About'},       // index 1 -> aboutSectionKey
    {'icon': Icons.work, 'label': 'Experience'},   // index 2 -> experienceSectionKey (was services)
    {'icon': Icons.folder, 'label': 'Projects'},   // index 3 -> projectsSectionKey
    {'icon': Icons.book, 'label': 'Hire Me'},      // index 4 -> hireMeSectionKey (add an icon for it)
    {'icon': Icons.mail, 'label': 'Contact'},      // index 5 -> contactMeSectionKey
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double iconWidgetSize = 39.0;
    final double halfIconWidgetSize = iconWidgetSize / 2;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.diameter,
          height: widget.diameter,
          child: Stack(
            children: [
              CustomPaint(
                size: Size.square(widget.diameter),
                painter: CircularPathPainter(
                  diameter: widget.diameter,
                  animationValue: _animation.value,
                  pathRadius: (widget.diameter / 2) - halfIconWidgetSize,
                ),
              ),
              ...icons.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> data = entry.value;

                double startAngle = -pi * 0.75;
                double sweepAngle = pi * 1.5;
                double angle = startAngle + (sweepAngle / (icons.length - 1)) * index;

                double radiusForIcons = (widget.diameter / 2) - halfIconWidgetSize;

                double centerX = widget.diameter / 2;
                double centerY = widget.diameter / 2;

                double iconCenterX = centerX + radiusForIcons * cos(angle);
                double iconCenterY = centerY + radiusForIcons * sin(angle);

                double iconVisibilityThreshold = index / (icons.length - 1);
                if (icons.length <= 1) iconVisibilityThreshold = 0.0;

                return Positioned(
                  left: iconCenterX - halfIconWidgetSize,
                  top: iconCenterY - halfIconWidgetSize,
                  child: Opacity(
                    opacity: _animation.value >= iconVisibilityThreshold ? 1.0 : 0.0,
                    child: GestureDetector(
                      onTap: () {
                        // ⭐ Call the scrollToSection method from the passed ScrollManager
                        widget.scrollManager.scrollToSection(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundSecondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.accentOrange, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          data['icon'],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}