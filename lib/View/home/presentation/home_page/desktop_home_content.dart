// lib/sections/hero_layouts/hero_desktop_layout.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/Shared/widgets/custom_button.dart';

import 'package:portfolio_web/View/home/presentation/Common_widgets/common_hero_widgets.dart';
import 'package:portfolio_web/core/constants/hero_data.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';


class HeroDesktopLayout extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double hiThereFontSize;
  final double nameFontSize;
  final double titleFontSize;
  final double projectTextFontSize;
  final double paragraphFontSize;

  const HeroDesktopLayout({
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


    double leftColumnWidthRatio = 0.5;
    double rightColumnWidthRatio = 0.5;
    final double mainCircularDiameter = screenWidth * rightColumnWidthRatio * 0.8;
    return SizedBox(
      height: screenHeight,
      child: Row(
        children: [

          // Left Column: Text Content
          Stack(
            children: [
              Container(
                color: AppColors.backgroundPrimary,
                width: screenWidth * leftColumnWidthRatio,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.02,
                  top: 50,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      HeroData.hiThere,
                      style: GoogleFonts.poppins( // Using GoogleFonts for consistency
                        fontSize: hiThereFontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentYellow, // Changed to accentYellow as per common design
                        letterSpacing: 2,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 5,
                      color: AppColors.accentYellow, // Changed to accentYellow
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    const SizedBox(height: 10),
                    buildSaritaText(nameFontSize), // Using common widget
                    Container(
                      width: 300,
                      height: 7,
                      color: AppColors.accentYellow, // Changed to accentYellow
                      margin: const EdgeInsets.only(bottom: 1),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: AppColors.backgroundSecondary, // Changed to backgroundSecondary
                      child: Text(
                        HeroData.title,
                        style: GoogleFonts.poppins( // Using GoogleFonts
                          decoration: TextDecoration.none,
                          color: AppColors.textPrimary, // Changed to textPrimary
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: AppColors.accentYellow, // Changed to accentYellow
                      child: Text(
                        HeroData.projectCallToAction,
                        style: GoogleFonts.poppins( // Using GoogleFonts
                          decoration: TextDecoration.none,
                          color: AppColors.blackText, // Changed to blackText for contrast
                          fontSize: projectTextFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      HeroData.paragraphText,
                      style: GoogleFonts.roboto(
                        fontSize: paragraphFontSize,
                        color: AppColors.paragraphText,
                        height: 1.5,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: HeroData.moreAboutMeButton,
                      onPressed: () {},
                      backgroundColor: Colors.transparent, // Transparent background
                      textColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: BorderSide(color: AppColors.paragraphText, width: 2), // Lighter border
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0, // Positioned at the start of the right column
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5, // Number of lines
                        (index) => Container(
                      width: 5,
                      height: 50,
                      color: AppColors.accentOrange,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Right Column: Image and Circular Nav
          Expanded(

            child: Container(
              color: AppColors.backgroundPrimary, // Consistent background
              child: SizedBox(
                width: screenWidth * rightColumnWidthRatio * 0.8, // The largest dimension
                height: screenHeight * rightColumnWidthRatio * 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 0, // Positioned at the start of the right column
                      top: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          5, // Number of lines
                              (index) => Container(
                            width: 5,
                            height: 50,
                            color: AppColors.accentOrange,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                      ),
                    ),
                    // Circular Image of Manahil
                    Container(
                      width: screenWidth * rightColumnWidthRatio * 0.7,
                      height: screenWidth * rightColumnWidthRatio * 0.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(HeroData.profileImage),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orangeAccent.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 15,
                            offset: const Offset(8, 8,),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCircularMenu(diameter: screenWidth * rightColumnWidthRatio * 0.8), // Using common widget
                  ],
                ),
              ),
            ),
          ),



        ],

      ),
    );

  }
}