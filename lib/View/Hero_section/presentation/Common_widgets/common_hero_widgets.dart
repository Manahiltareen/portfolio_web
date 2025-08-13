import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_web/View/Hero_section/presentation/Common_widgets/dashed_circle_painter.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:portfolio_web/core/theme/app_text_styles.dart';

Widget buildSaritaText(double fontSize) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      HoverText(
        text:"I'M",
        fontSize: 70,
      ),

      const SizedBox(width: 10),
      Stack(
        children: [


          Text(
            "MANAHIL",
            style: TextStyle(
              fontSize: 70,

              fontWeight: FontWeight.bold,

              decoration: TextDecoration.none,

              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.2
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

// return SizedBox(

// width: diameter + 0, // Make the canvas slightly larger than the image

// height: diameter + 0,

// child: CustomPaint(

// painter: CircularPathPainter(diameter: diameter),

// child: Stack(

// children: [

// // List of icon data

// buildCircularIcons(diameter),

// ],

// ),

// ),

// );

// }

class AnimatedCircularMenu extends StatefulWidget {
  final double diameter;

  const AnimatedCircularMenu({super.key, required this.diameter});

  @override
  State<AnimatedCircularMenu> createState() => _AnimatedCircularMenuState();
}

class _AnimatedCircularMenuState extends State<AnimatedCircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  final List<Map<String, dynamic>> icons = [
    {'icon': Icons.home, 'label': 'Home'},

    {'icon': Icons.person, 'label': 'About'},

    {'icon': Icons.work, 'label': 'Services'}, // Briefcase-like

    {'icon': Icons.folder, 'label': 'Projects'}, // Folder-like

    {'icon': Icons.mail, 'label': 'Contact'}, // Mail-like
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Total animation duration

      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,

      curve: Curves.easeInOutCubic, // Smooth animation curve
    );

// Start the animation when the widget loads

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// --- Start of Fix: Define icon sizes here ---

// Calculate the total rendered size of an icon widget (including padding and border)

// Icon size (20) + padding (8 on each side) = 20 + 8*2 = 36.

    final double iconWidgetSize = 39.0;

    final double halfIconWidgetSize = iconWidgetSize / 2; // = 18.0

// --- End of Fix ---

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

// Now halfIconWidgetSize is accessible here

                  pathRadius: (widget.diameter / 2) - halfIconWidgetSize,
                ),
              ),
              ...icons.asMap().entries.map((entry) {
                int index = entry.key;

                Map<String, dynamic> data = entry.value;

// These variables are now defined globally in the build method,

// no need to redefine them here:

// final double iconWidgetSize = 36.0;

// final double halfIconWidgetSize = iconWidgetSize / 2;

                double startAngle = -pi * 0.75;

                double sweepAngle = pi * 1.5;

                double angle =
                    startAngle + (sweepAngle / (icons.length - 1)) * index;

// Adjust radiusForIcons:

// Subtract half the icon's total size from the main circle's radius.

// This places the icon's center inwards, so its edges don't get clipped.

                double radiusForIcons =
                    (widget.diameter / 2) - halfIconWidgetSize;

// Center of the main SizedBox, where the circle's origin is

                double centerX = widget.diameter / 2;

                double centerY = widget.diameter / 2;

// Calculate the center position of the current icon

                double iconCenterX = centerX + radiusForIcons * cos(angle);

                double iconCenterY = centerY + radiusForIcons * sin(angle);

// Calculate the threshold for this icon to appear

                double iconVisibilityThreshold = index / (icons.length - 1);

                if (icons.length <= 1)
                  iconVisibilityThreshold = 0.0; // Handle single icon case

                return Positioned(
// Position the top-left corner of the icon widget

                  left: iconCenterX -
                      halfIconWidgetSize, // Subtract half its size to center

                  top: iconCenterY -
                      halfIconWidgetSize, // Subtract half its size to center

                  child: Opacity(
                    opacity:
                        _animation.value >= iconVisibilityThreshold ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.blackText,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.accentOrange, width: 1.5),
                      ),
                      child: Icon(
                        data['icon'],
                        color: Colors.white,
                        size: 20,
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



// Assuming AppColors is defined elsewhere, e.g., in core/theme/colors.dart
// For demonstration, let's define a dummy AppColors if it's not provided:


// You will need this CustomPainter for your circular menu path.
// If you don't have it, here's a basic one:
