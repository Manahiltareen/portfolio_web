// lib/sections/hero_layouts/hero_tablet_layout.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/Shared/widgets/custom_button.dart';
import 'package:portfolio_web/View/Hero_section/presentation/Common_widgets/common_hero_widgets.dart';

import 'package:portfolio_web/core/constants/hero_data.dart';

import 'package:portfolio_web/core/theme/app_colors.dart';
// Import common hero widgets

class HeroTabletLayout extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double hiThereFontSize;
  final double nameFontSize;
  final double titleFontSize;
  final double projectTextFontSize;
  final double paragraphFontSize;

  const HeroTabletLayout({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.hiThereFontSize,
    required this.nameFontSize,
    required this.titleFontSize,
    required this.projectTextFontSize,
    required this.paragraphFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image and Circular Nav - Top on tablet
        Container(
          color: AppColors.backgroundPrimary, // Consistent background
          height: screenHeight * 0.5, // Adjust this as needed for tablet
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(HeroData.profileImage),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              // AnimatedCircularMenu(
              //   diameter: 200,
              //   scrollManager: scrollManager, // ⭐ Pass the scrollManager
              // ),
              // Using common widget
            ],
          ),
        ),

        // Text Content - Bottom on tablet
        Container(
          color: AppColors.backgroundPrimary, // Consistent background
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 4,
                color: AppColors.accentYellow, // Changed to accentYellow
                margin: const EdgeInsets.only(bottom: 8),
              ),
              Text(
                HeroData.hiThere,
                style: GoogleFonts.poppins(
                  fontSize: hiThereFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentYellow,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              buildSaritaText(nameFontSize), // Using common widget

              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: AppColors.backgroundSecondary, // Changed to backgroundSecondary
                child: Text(
                  HeroData.title,
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimary,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: AppColors.accentYellow, // Changed to accentYellow
                child: Text(
                  HeroData.projectCallToAction,
                  style: GoogleFonts.poppins(
                    color: AppColors.blackText, // Changed to blackText
                    fontSize: projectTextFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                HeroData.paragraphText,
                style: GoogleFonts.roboto(
                  fontSize: paragraphFontSize,
                  color: AppColors.paragraphText,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 25),
              CustomButton(
                text: HeroData.moreAboutMeButton,
                onPressed: () {},
                backgroundColor: Colors.transparent,
                textColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                border: BorderSide(color: AppColors.paragraphText, width: 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}