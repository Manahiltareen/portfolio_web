import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart'; // Keep your original import if it works for you
import 'package:portfolio_web/core/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';


class HireMeSection extends StatelessWidget {
  const HireMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary,
      // ⭐ Adjusted constraints to be more flexible and prevent overflow
      // Removed maxHeight to let it grow as needed by content, within a Scrollable parent if overflow occurs.
      // If this section is inside a SingleChildScrollView for the whole page,
      // then fixed height or min/max height here can cause issues.
      // Best approach is often to let the content dictate height within a parent that handles scrolling.
      // For this specific section to be around 40% but avoid overflow, we'll try to fit it.
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.40, // Aim for at least 40%
        // Removed explicit maxHeight to allow it to expand slightly if necessary
        // to fit content without overflow, especially on smaller desktop/larger mobile views.
        // If it MUST be capped, use a slightly larger maxHeight like screenHeight * 0.50.
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 30 : 20, // ⭐ Further reduced vertical padding for smaller screens
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
        children: [
          // "FREELANCE" text
          Text(
            'FREELANCE',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 14 : 11, // ⭐ Further reduced font size
              color: AppColors.textPrimary.withOpacity(0.7),
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: isDesktop ? 8 : 4), // ⭐ Further reduced SizedBox height
          HoverText(
            text: 'Hire Me As A Freelancer',
            fontSize: isDesktop ? 28 : 20,
          ),
          // "Hire Me As A Freelancer" title

          SizedBox(height: isDesktop ? 15 : 8), // ⭐ Further reduced SizedBox height

          // Description text
          Text(
            'I am available on different freelancing platforms. \nYou can Hire Me on given platforms.',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: isDesktop ? 14 : 11, // ⭐ Further reduced font size
              color: AppColors.paragraphText,
              height: 1.5,
            ),
          ),
          SizedBox(height: isDesktop ? 30 : 15), // ⭐ Further reduced SizedBox height

          // Freelance Platform Buttons
          Wrap(
            spacing: isDesktop ? 30 : 10, // ⭐ Further reduced horizontal space between buttons
            runSpacing: isDesktop ? 0 : 10, // ⭐ Further reduced vertical space on wrap
            alignment: WrapAlignment.center,
            children: [
              _buildFreelanceButton(
                context,
                'FIVERR',
                'https://www.fiverr.com/your_fiverr_profile', // Replace with your Fiverr link
                isDesktop,
              ),
              _buildFreelanceButton(
                context,
                'UPWORK',
                'https://www.upwork.com/your_upwork_profile', // Replace with your Upwork link
                isDesktop,
              ),
              _buildFreelanceButton(
                context,
                'GURU',
                'https://www.guru.com/your_guru_profile', // Replace with your Guru link
                isDesktop,
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 40 : 20), // ⭐ Final adjustment for bottom padding
        ],
      ),
    );
  }

  Widget _buildFreelanceButton(BuildContext context, String platformName, String url, bool isDesktop) {
    return Column(
      children: [
        Text(
          platformName,
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 20 : 15, // ⭐ Further reduced Platform name font size
            fontWeight: FontWeight.bold,
            color: AppColors.accentOrange,
          ),
        ),
        SizedBox(height: isDesktop ? 10 : 5), // ⭐ Further reduced space between platform name and button
        OutlinedButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch $platformName link: $url')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: BorderSide(color: AppColors.accentOrange, width: 2),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 25 : 18, // ⭐ Further reduced horizontal padding
              vertical: isDesktop ? 10 : 8, // ⭐ Further reduced vertical padding for button
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: isDesktop ? 12 : 9, // ⭐ Further reduced font size for "HIRE ME" text
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('HIRE ME'),
        ),
      ],
    );
  }
}