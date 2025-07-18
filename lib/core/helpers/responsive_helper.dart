// import 'package:flutter/material.dart';
// class ResponsiveLayout extends StatelessWidget {
//   Widget tablet;
//   Widget mobile;
//   Widget desktop;
//   ResponsiveLayout({super.key, required this.mobile, required this.desktop, required this.tablet});
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints){
//       if(constraints.maxWidth < 550)
//         return mobile;
//       else if (constraints.maxWidth < 1100)
//         return tablet;
//       else
//         return desktop;
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:portfolio_web/Shared/dimensions/breakpoints.dart';
// Import your breakpoints

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet; // Optional for tablet-specific layout
  final Widget desktop;

  const ResponsiveLayoutBuilder({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < kTabletBreakpoint; // Using tablet breakpoint as mobile upper limit

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= kTabletBreakpoint &&
          MediaQuery.of(context).size.width < kDesktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= kDesktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= kDesktopBreakpoint) {
          return desktop;
        } else if (constraints.maxWidth >= kTabletBreakpoint) {
          return tablet ?? mobile; // Fallback to mobile if tablet is not provided
        } else {
          return mobile;
        }
      },
    );
  }
}