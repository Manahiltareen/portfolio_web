// lib/sections/new_hero_section_content.dart
import 'package:flutter/material.dart';

import 'package:portfolio_web/View/home/presentation/home_page/desktop_home_content.dart';
import 'package:portfolio_web/View/home/presentation/home_page/mobile_home_content.dart';
import 'package:portfolio_web/View/home/presentation/home_page/tablet_home_content.dart';
import 'package:portfolio_web/core/helpers/responsive_helper.dart';

class NewHeroSectionContent extends StatelessWidget {
  const NewHeroSectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double hiThereFontSize;
    double nameFontSize; // Renamed from saritaFontSize
    double titleFontSize; // Renamed from designerPhotographerFontSize
    double projectTextFontSize;
    double paragraphFontSize;

    if (ResponsiveLayoutBuilder.isDesktop(context)) {
      hiThereFontSize = 24;
      nameFontSize = screenWidth * 0.1;
      titleFontSize = 18;
      projectTextFontSize = 16;
      paragraphFontSize = 16;
    } else if (ResponsiveLayoutBuilder.isTablet(context)) {
      hiThereFontSize = 20;
      nameFontSize = screenWidth * 0.12;
      titleFontSize = 16;
      projectTextFontSize = 14;
      paragraphFontSize = 14;
    } else { // Mobile
      hiThereFontSize = 16;
      nameFontSize = screenWidth * 0.07;
      titleFontSize = 14;
      projectTextFontSize = 12;
      paragraphFontSize = 12;
    }

    return ResponsiveLayoutBuilder(
      desktop: HeroDesktopLayout(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        hiThereFontSize: hiThereFontSize,
        nameFontSize: nameFontSize,
        titleFontSize: titleFontSize,
        projectTextFontSize: projectTextFontSize,
        paragraphFontSize: paragraphFontSize,
      ),
      tablet: HeroTabletLayout(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        hiThereFontSize: hiThereFontSize,
        nameFontSize: nameFontSize,
        titleFontSize: titleFontSize,
        projectTextFontSize: projectTextFontSize,
        paragraphFontSize: paragraphFontSize,
      ),
      mobile: HeroMobileLayout(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        hiThereFontSize: hiThereFontSize,
        nameFontSize: nameFontSize,
        titleFontSize: titleFontSize,
        projectTextFontSize: projectTextFontSize,
        paragraphFontSize: paragraphFontSize,
      ),
    );
  }
}