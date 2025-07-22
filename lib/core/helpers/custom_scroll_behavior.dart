// lib/core/helpers/custom_scroll_behavior.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override this to allow mouse and touch scrolling
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    // Add other pointer device kinds if needed, e.g., PointerDeviceKind.stylus
  };

  // Optionally, you can remove the default glowing overscroll indicator on web
  // which might look out of place if you're not targeting mobile.
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // Disable the default overscroll indicator
  }

// You can also customize scroll physics if needed, but for basic scrolling,
// it's often not necessary to override this.
// @override
// ScrollPhysics getScrollPhysics(BuildContext context) {
//   return const ClampingScrollPhysics(); // Or BouncingScrollPhysics, etc.
// }
}