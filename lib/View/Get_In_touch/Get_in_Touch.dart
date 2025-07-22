import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/Shared/widgets/Social_Icons.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart'; // Ensure this path is correct
import 'package:portfolio_web/core/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
// For social media icons

class ContactMeSection extends StatelessWidget {
  const ContactMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundSecondary,
      // Dark background as seen in contact_me.png
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 40 : 40,
        // Adjust vertical padding for spacing from other sections
        horizontal: isDesktop ? MediaQuery
            .of(context)
            .size
            .width * 0.1 : 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Takes minimum vertical space
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // "Get in Touch" title with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline, // Email icon
                color: AppColors.accentOrange, // Orange accent color
                size: isDesktop ? 30 : 24,
              ),
              SizedBox(width: isDesktop ? 10 : 8),
              HoverText(
                text: 'Get in Touch',
                fontSize: isDesktop ? 32 : 24,
              ),

            ],
          ),
          SizedBox(height: isDesktop ? 30 : 25),
          // Space between title and social icons

          // Social Media Icons
          Wrap(
            spacing: isDesktop ? 30 : 20, // Horizontal space between icons
            alignment: WrapAlignment.center,
            children: [
              buildSocialIcon(
                FontAwesomeIcons.envelope, // Mail icon for email link
                'mailto:your.email@example.com',
                // ⭐ Replace with your actual email
                isDesktop,
              ),
              buildSocialIcon(
                FontAwesomeIcons.github, // GitHub icon
                'https://github.com/your_github_profile',
                // ⭐ Replace with your GitHub link
                isDesktop,
              ),
              buildSocialIcon(
                FontAwesomeIcons.linkedinIn, // LinkedIn icon
                'https://linkedin.com/in/your_linkedin_profile',

                isDesktop,
              ),
              buildSocialIcon(
                FontAwesomeIcons.instagram, // Twitter icon
                'https://twitter.com/your_twitter_profile',

                isDesktop,
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 30 : 20),


          // Copyright text
          Text(
            '© 2025 ManahilTareen. All rights reserved.',

            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: isDesktop ? 14 : 12,
              color: AppColors.paragraphText,
            ),
          ),
        ],
      ),
    );
  }
}
  // Helper method to build individual social media icons
