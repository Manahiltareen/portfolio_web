import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/View/main_web_page/main_web_page.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ServiceHoverCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final int projects;

  const ServiceHoverCard({
    super.key,
    required this.icon,
    required this.title,
    required this.projects,
  });

  @override
  State<ServiceHoverCard> createState() => _ServiceHoverCardState();
}

class _ServiceHoverCardState extends State<ServiceHoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double boxSize = 250;
    final double iconSize = 60;
    final double titleFontSize = 22;
    final double projectFontSize = 16;

    return MouseRegion(
      onEnter: (a) => setState(() => _isHovered = true),
      onExit: (a) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0, // Existing scale animation
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          // ⭐ Use AnimatedContainer to animate color and box shadow
          duration: const Duration(
              milliseconds: 200), // Match scale animation duration
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(5),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accentOrange
                          .withOpacity(0.5), // ⭐ Stronger glow on hover
                      spreadRadius:
                          8, // ⭐ Increased spread radius for a more prominent glow
                      blurRadius: 15, // ⭐ Increased blur radius
                      offset: const Offset(0, 8), // ⭐ Offset for shadow
                    ),
                  ]
                : [
                    BoxShadow(
                      // Default shadow, making it subtle or transparent when not hovered
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2, // Smaller default spread
                      blurRadius: 5, // Smaller default blur
                      offset: const Offset(0, 3), // Subtle default offset
                    ),
                  ],
            border: _isHovered
                ? Border.all(
                    color: AppColors.accentOrange,
                    width: 2) // ⭐ Border on hover
                : null, // No border when not hovered
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: iconSize, color: AppColors.accentOrange),
              const SizedBox(height: 15),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: titleFontSize,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${widget.projects} projects",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: projectFontSize,
                  color: AppColors.paragraphText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedStatisticItem extends StatefulWidget {
  final String value;
  final String label;

  const AnimatedStatisticItem({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  State<AnimatedStatisticItem> createState() => _AnimatedStatisticItemState();
}

class _AnimatedStatisticItemState extends State<AnimatedStatisticItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _targetNumber = 0;
  String _suffix = '';
  bool _animationStarted = false; // Track if animation has already started

  @override
  void initState() {
    super.initState();

    _parseValueString(widget.value);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: _targetNumber.toDouble()).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  void _parseValueString(String valueString) {
    final RegExp numberRegExp = RegExp(r'^\d+');
    final match = numberRegExp.firstMatch(valueString);

    if (match != null) {
      _targetNumber = int.tryParse(match.group(0)!) ?? 0;
      _suffix = valueString.substring(match.end);
    } else {
      _targetNumber = 0;
      _suffix = valueString;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Add a unique key for VisibilityDetector
    final Key visibilityKey = Key('statistic-item-${widget.label}');

    return VisibilityDetector(
      key: visibilityKey,
      onVisibilityChanged: (visibilityInfo) {
        // Check if the widget is at least 50% visible and animation hasn't started yet
        if (visibilityInfo.visibleFraction > 0.5 && !_animationStarted) {
          _controller.forward(); // Start the animation
          _animationStarted = true; // Mark as started
        }
        // If it scrolls out of view and you want it to re-animate when it comes back,
        // you could potentially reset _animationStarted and _controller.reset(),
        // but typically for stats, it animates once.
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              // If animation hasn't started, show 0 or default. Otherwise, show animated value.
              _animationStarted
                  ? "${_animation.value.toInt()}${_suffix}"
                  : "0${_suffix}",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 15,
                color: AppColors.paragraphText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// --- Existing _buildVerticalSideNavbar method (remains the same) ---
// Import the notifier

// Assume this notifier exists, as in previous conversations
// It helps update the active state of the navbar items.
// class ActiveSectionNotifier extends ValueNotifier<int> {
//   ActiveSectionNotifier() : super(0); // Initial active section is 0 (Home)
//
//   void setActiveSection(int index) {
//     if (value != index) {
//       value = index;
//     }
//   }
// }

// Ensure correct import for ActiveSectionNotifier

 // Ensure correct import for ActiveSectionNotifier

Widget buildVerticalSideNavbar(
    BuildContext context, {
      required ActiveSectionNotifier activeSectionNotifier,
      required ScrollController scrollController,
      required List<double> sectionOffsets, // ⭐ New parameter
    }) {

  final List<Map<String, dynamic>> sections = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.person, 'label': 'About'},
    {'icon': Icons.work, 'label': 'Services'}, // Assuming ExperienceSection maps to Services
    {'icon': Icons.folder, 'label': 'Projects'},
    {'icon': Icons.mail, 'label': 'Contact'},
  ];

  return ValueListenableBuilder<int>(
    valueListenable: activeSectionNotifier,
    builder: (context, activeIndex, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: sections.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> data = entry.value;
          bool isActive = index == activeIndex;

          return GestureDetector(
            onTap: () {
              if (index < sectionOffsets.length) {
                scrollController.animateTo(
                  sectionOffsets[index], // ⭐ Use the passed offsets
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                );
                // No need to setActiveSection here, as _onScroll will handle it based on actual scroll position
                // which prevents conflicts if user manually scrolls.
                // activeSectionNotifier.setActiveSection(index); // Removed this line
              }
              print('Tapped section: ${data['label']} (Index: $index)');
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? AppColors.accentOrange : AppColors.paragraphText.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    data['icon'],
                    color: isActive ? AppColors.accentYellow : AppColors.textPrimary.withOpacity(0.7),
                    size: 20,
                  ),
                ),
                if (index < sections.length - 1)
                  Container(
                    width: 2,
                    height: 60,
                    color: AppColors.paragraphText.withOpacity(0.3),
                  ),
              ],
            ),
          );
        }).toList(),
      );
    },
  );
}//