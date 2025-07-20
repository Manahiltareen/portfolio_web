// lib/core/managers/scroll_manager.dart
import 'package:flutter/material.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';

class ScrollManager {
  final ScrollController scrollController = ScrollController();
  final GlobalKey scrollableKey = GlobalKey();

  // Define GlobalKeys for each section
  final GlobalKey homeSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey experienceSectionKey = GlobalKey(); // Maps to Services/Work in menu
  final GlobalKey projectsSectionKey = GlobalKey();
  final GlobalKey hireMeSectionKey = GlobalKey();
  final GlobalKey contactMeSectionKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;
  List<double> _sectionScrollOffsets = []; // Will be populated after layout
  final ActiveSectionNotifier activeSectionNotifier;

  // Callback to notify the UI when the navbar visibility should change
  // (e.g., in HomePage's _onScroll, you'd use this to setState)
  Function(bool)? onNavbarVisibilityChanged;

  // Callback to trigger a rebuild (e.g., in HomePage) when offsets are calculated
  // This is crucial if widgets depend on _sectionScrollOffsets immediately after calculation.
  VoidCallback? onOffsetsCalculated;

  ScrollManager(this.activeSectionNotifier) {
    _sectionKeys = [
      homeSectionKey,
      aboutSectionKey,
      experienceSectionKey,
      projectsSectionKey,
      hireMeSectionKey,
      contactMeSectionKey,
    ];
    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }

  void calculateSectionOffsets() {
    final RenderBox? scrollableRenderBox = scrollableKey.currentContext?.findRenderObject() as RenderBox?;
    if (scrollableRenderBox == null || !scrollableRenderBox.hasSize) {
      _sectionScrollOffsets = [];
      return;
    }

    _sectionScrollOffsets = _sectionKeys.map((key) {
      final RenderBox? sectionRenderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (sectionRenderBox == null || !sectionRenderBox.hasSize) {
        return 0.0;
      }
      final Offset offsetInScrollable = sectionRenderBox.localToGlobal(Offset.zero, ancestor: scrollableRenderBox);
      return offsetInScrollable.dy;
    }).toList();

    onOffsetsCalculated?.call(); // Notify listeners that offsets are ready
  }

  void _onScroll() {
    // Re-calculate if offsets are empty (e.g., after hot restart or initial load)
    if (_sectionScrollOffsets.isEmpty) {
      calculateSectionOffsets();
      if (_sectionScrollOffsets.isEmpty) return; // Still empty, exit
    }

    final scrollPosition = scrollController.position.pixels;
    int currentActiveIndex = activeSectionNotifier.value;
    final viewportHeight = WidgetsBinding.instance.window.physicalSize.height / WidgetsBinding.instance.window.devicePixelRatio; // Get actual viewport height

    // Logic to hide/show navbar (can be adapted by HomePage)
    final RenderBox? homeRenderBox = homeSectionKey.currentContext?.findRenderObject() as RenderBox?;
    if (homeRenderBox != null) {
      final double homeSectionHeight = homeRenderBox.size.height;
      bool shouldShowNavbar = scrollPosition > (homeSectionHeight * 0.75);
      onNavbarVisibilityChanged?.call(shouldShowNavbar); // Callback to HomePage
    }

    // Refined active section detection
    for (int i = 0; i < _sectionKeys.length; i++) {
      if (i >= _sectionScrollOffsets.length) continue;

      final double sectionStartOffset = _sectionScrollOffsets[i];
      final RenderBox? renderBox = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final double sectionHeight = renderBox.size.height;
        final double sectionEndOffset = sectionStartOffset + sectionHeight;

        if (scrollPosition >= sectionStartOffset - (viewportHeight * 0.2) &&
            scrollPosition < sectionEndOffset - (viewportHeight * 0.2)) {
          if (currentActiveIndex != i) {
            activeSectionNotifier.setActiveSection(i);
            break;
          }
        }
      }
    }
  }

  void scrollToSection(int index) {
    if (index >= 0 && index < _sectionScrollOffsets.length) {
      scrollController.animateTo(
        _sectionScrollOffsets[index],
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      activeSectionNotifier.setActiveSection(index);
    }
  }

  // Getter to provide section offsets to external widgets
  List<double> get sectionScrollOffsets => _sectionScrollOffsets;

  // Getter to provide section keys to external widgets
  List<GlobalKey> get sectionKeys => _sectionKeys;
}