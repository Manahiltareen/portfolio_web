import 'package:flutter/material.dart';
import 'package:portfolio_web/Shared/widgets/responsive_layout_builder.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // ResponsiveLayoutBuilder(
      //   mobile: const MobileHomeContent(),
      //   tablet: const TabletHomeContent(), // Optional, if you have a distinct tablet layout
      //   desktop: const DesktopHomeContent(),
      // ),
    );
  }
}