import 'package:flutter/material.dart';
import 'package:portfolio_web/View/Experience_Section/presentation/Experience_page/ExperienceSection.dart';
import 'package:portfolio_web/View/Get_In_touch/Get_in_Touch.dart';
import 'package:portfolio_web/View/Hero_section/presentation/home_screen.dart';
import 'package:portfolio_web/View/Hire_Me/hire_me_section.dart';
import 'package:portfolio_web/View/Project_Section/presentation/projects_pages/Desktop_project_content.dart';
import 'package:portfolio_web/View/about/Presentation/About_pages/desktop_about_content.dart';
import 'package:portfolio_web/View/about/Presentation/Common_widgets/common_about_widgets.dart';

import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';
 // Assuming this is where buildVerticalSideNavbar is

// ActiveSectionNotifier class (ensure this is in lib/core/notifiers/active_section_notifier.dart ONLY)
// Do NOT define it here in HomePage.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ActiveSectionNotifier _activeSectionNotifier = ActiveSectionNotifier();
  final ScrollController _scrollController = ScrollController();

  // ⭐ New: GlobalKey for the SingleChildScrollView itself
  final GlobalKey _scrollableKey = GlobalKey();

  final GlobalKey _homeSectionKey = GlobalKey();
  final GlobalKey _aboutSectionKey = GlobalKey();
  final GlobalKey _servicesSectionKey = GlobalKey();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _hireMeSectionKey = GlobalKey();
  final GlobalKey _contactMeSectionKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;
  late List<double> _sectionScrollOffsets = []; // Initialize as empty list

  bool _showNavbar = false;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _homeSectionKey,
      _aboutSectionKey,
      _servicesSectionKey,
      _projectsSectionKey,
      _hireMeSectionKey,
      _contactMeSectionKey,
    ];

    _scrollController.addListener(_onScroll);

    // ⭐ Post-frame callback to calculate initial offsets after layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
      // Optionally, call _onScroll here to set initial active section and navbar visibility
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSectionNotifier.dispose();
    super.dispose();
  }

  // ⭐ New Method: Calculate and store section offsets
  void _calculateSectionOffsets() {
    // Ensure the scrollable widget's render box is available
    final RenderBox? scrollableRenderBox = _scrollableKey.currentContext?.findRenderObject() as RenderBox?;
    if (scrollableRenderBox == null || !scrollableRenderBox.hasSize) {
      // If scrollable isn't ready, retry later or handle error
      _sectionScrollOffsets = []; // Clear or keep previous if partial layout is possible
      return;
    }

    _sectionScrollOffsets = _sectionKeys.map((key) {
      final RenderBox? sectionRenderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (sectionRenderBox == null || !sectionRenderBox.hasSize) {
        return 0.0; // Return a default or handle sections not yet rendered
      }

      // Calculate the offset of the section relative to the top of the SingleChildScrollView
      // Use the ancestor parameter to get the position relative to the scrollable widget
      final Offset offsetInScrollable = sectionRenderBox.localToGlobal(Offset.zero, ancestor: scrollableRenderBox);

      // The 'dy' value of this offset is the scroll position required to bring
      // the top of the section to the top of the scrollable area.
      return offsetInScrollable.dy;
    }).toList();
  }


  void _onScroll() {
    // Check if _sectionScrollOffsets is populated before using it
    if (_sectionScrollOffsets.isEmpty) {
      _calculateSectionOffsets(); // Attempt to calculate if not already
      if (_sectionScrollOffsets.isEmpty) return; // Still empty, exit
    }

    final scrollPosition = _scrollController.position.pixels;
    int currentActiveIndex = _activeSectionNotifier.value;
    final viewportHeight = MediaQuery.of(context).size.height;

    // ⭐ Logic to hide/show navbar
    final RenderBox? homeRenderBox = _homeSectionKey.currentContext?.findRenderObject() as RenderBox?;
    if (homeRenderBox != null) {
      final double homeSectionHeight = homeRenderBox.size.height;
      // Show when scrolled past a significant portion of the Hero section
      bool shouldShow = scrollPosition > (homeSectionHeight * 0.75); // Adjust 0.75 as needed

      if (_showNavbar != shouldShow) {
        setState(() {
          _showNavbar = shouldShow;
        });
      }
    }

    // ⭐ Refined active section detection
    for (int i = 0; i < _sectionKeys.length; i++) {
      // Ensure we don't go out of bounds if _sectionScrollOffsets is smaller
      if (i >= _sectionScrollOffsets.length) continue;

      final double sectionStartOffset = _sectionScrollOffsets[i];
      final RenderBox? renderBox = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final double sectionHeight = renderBox.size.height;
        final double sectionEndOffset = sectionStartOffset + sectionHeight;

        // Consider a section active if its top is near the top of the viewport
        // or a significant portion is visible.
        // Adjust these thresholds (e.g., 0.2 and 0.8) as needed for your visual preference.
        if (scrollPosition >= sectionStartOffset - (viewportHeight * 0.2) && // Section starts appearing
            scrollPosition < sectionEndOffset - (viewportHeight * 0.2)) { // Section is still mostly visible
          if (currentActiveIndex != i) {
            _activeSectionNotifier.setActiveSection(i);
            break;
          }
        }
      }
    }
  }

  // _getSectionOffset is no longer needed directly if _sectionScrollOffsets are pre-calculated.
  // Keeping it commented out or removing it is fine.
  // double _getSectionOffset(GlobalKey key) {
  //   final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  //   if (renderBox == null) return 0.0;
  //   return renderBox.localToGlobal(Offset.zero).dy + _scrollController.position.pixels - MediaQuery.of(context).padding.top;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            key: _scrollableKey, // ⭐ Assign the new key to SingleChildScrollView
            controller: _scrollController,
            child: Column(
              children: [
                NewHeroSectionContent(key: _homeSectionKey),
                DesktopAboutContent(key: _aboutSectionKey),
                ExperienceSection(key: _servicesSectionKey),
                ProjectSection(key: _projectsSectionKey),
                HireMeSection(key: _hireMeSectionKey),
                ContactMeSection(key: _contactMeSectionKey),
              ],
            ),
          ),
          if (Responsive.isDesktop(context) && _showNavbar)
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.2, // Adjust as needed
              child: buildVerticalSideNavbar(
                context,
                activeSectionNotifier: _activeSectionNotifier,
                scrollController: _scrollController,
                sectionOffsets: _sectionScrollOffsets,
              ),
            ),
        ],
      ),
    );
  }
}
