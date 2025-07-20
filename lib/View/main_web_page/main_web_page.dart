// HomePage.dart
import 'package:flutter/material.dart';
import 'package:portfolio_web/View/Experience_Section/presentation/Experience_page/ExperienceSection.dart';
import 'package:portfolio_web/View/Get_In_touch/Get_in_Touch.dart';
import 'package:portfolio_web/View/Hero_section/presentation/home_screen.dart'; // This is NewHeroSectionContent
import 'package:portfolio_web/View/Hire_Me/hire_me_section.dart';
import 'package:portfolio_web/View/Project_Section/presentation/projects_pages/Desktop_project_content.dart';
import 'package:portfolio_web/View/about/Presentation/About_pages/desktop_about_content.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/manager/Scroll_manager.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';


// Assuming buildVerticalSideNavbar is in Common_widgets/common_about_widgets.dart or similar
import 'package:portfolio_web/View/about/Presentation/Common_widgets/common_about_widgets.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ActiveSectionNotifier _activeSectionNotifier = ActiveSectionNotifier();
  late final ScrollManager _scrollManager; // ⭐ Use the manager

  bool _showNavbar = false; // State to control vertical navbar visibility

  @override
  void initState() {
    super.initState();
    _scrollManager = ScrollManager(_activeSectionNotifier);

    // ⭐ Set the callback for navbar visibility changes
    _scrollManager.onNavbarVisibilityChanged = (bool shouldShow) {
      if (_showNavbar != shouldShow) {
        setState(() {
          _showNavbar = shouldShow;
        });
      }
    };

    // ⭐ Set the callback for when offsets are calculated
    _scrollManager.onOffsetsCalculated = () {
      // If any widget dependent on _sectionScrollOffsets needs a rebuild,
      // call setState here. For the vertical navbar, it implicitly rebuilds
      // because its parent's _showNavbar state changes.
      setState(() {
        // This setState is minimal, just to trigger a rebuild if necessary
        // for widgets that are direct children of HomePage and depend on
        // _scrollManager.sectionScrollOffsets
      });
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollManager.calculateSectionOffsets();
      _scrollManager.activeSectionNotifier.setActiveSection(0); // Set initial active section
    });
  }

  @override
  void dispose() {
    _scrollManager.dispose(); // Dispose the manager
    _activeSectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            key: _scrollManager.scrollableKey, // ⭐ Use manager's key
            controller: _scrollManager.scrollController, // ⭐ Use manager's controller
            child: Column(
              children: [
                NewHeroSectionContent(
                  key: _scrollManager.homeSectionKey,
                  activeSectionNotifier: _activeSectionNotifier, // ⭐ Add this
                  scrollManager: _scrollManager, // ⭐ Add this
                ),
                DesktopAboutContent(key: _scrollManager.aboutSectionKey),
                ExperienceSection(key: _scrollManager.experienceSectionKey),
                ProjectSection(key: _scrollManager.projectsSectionKey),
                HireMeSection(key: _scrollManager.hireMeSectionKey),
                ContactMeSection(key: _scrollManager.contactMeSectionKey),
              ],
            ),
          ),
          // ⭐ Vertical Side Navbar
          if (Responsive.isDesktop(context) && _showNavbar)
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.2,
              child: buildVerticalSideNavbar(
                context,
                activeSectionNotifier: _activeSectionNotifier,
                scrollController: _scrollManager.scrollController, // ⭐ Use manager's controller
                sectionOffsets: _scrollManager.sectionScrollOffsets, // ⭐ Use manager's offsets
                onIconTapped: _scrollManager.scrollToSection, // Pass the scroll function
              ),
            ),
        ],
      ),
    );
  }
}

// ⭐ IMPORTANT: Update buildVerticalSideNavbar to accept onIconTapped
// You might have this in a separate file like common_about_widgets.dart
Widget buildVerticalSideNavbar(
    BuildContext context, {
      required ActiveSectionNotifier activeSectionNotifier,
      required ScrollController scrollController,
      required List<double> sectionOffsets,
      required Function(int) onIconTapped, // ⭐ Add this parameter
    }) {
  // ... (Your existing buildVerticalSideNavbar code)
  // Inside this function, for each navigation item (e.g., using a ListView.builder or Column of buttons),
  // when an item is tapped, call onIconTapped(index).
  // Example for a simple button:
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: activeSectionNotifier,
          builder: (context, activeIndex, child) {
            return Column(
              children: [
                _buildNavItem(Icons.home, 'Home', 0, activeIndex, onIconTapped),
                _buildNavItem(Icons.person, 'About', 1, activeIndex, onIconTapped),
                _buildNavItem(Icons.work, 'Experience', 2, activeIndex, onIconTapped),
                _buildNavItem(Icons.folder, 'Projects', 3, activeIndex, onIconTapped),
                _buildNavItem(Icons.book, 'Hire Me', 4, activeIndex, onIconTapped), // Example icon for Hire Me
                _buildNavItem(Icons.mail, 'Contact', 5, activeIndex, onIconTapped),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// Helper method for buildVerticalSideNavbar
Widget _buildNavItem(IconData icon, String label, int index, int activeIndex, Function(int) onIconTapped) {
  final bool isActive = index == activeIndex;
  return GestureDetector(
    onTap: () => onIconTapped(index), // ⭐ Call the passed function
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.accentOrange : Colors.white,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.accentOrange : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}