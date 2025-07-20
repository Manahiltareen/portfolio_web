import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/View/Experience_Section/presentation/Common_widget/ExperienceTimelineTile.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    // No need for screenHeight here if we want content to dictate height, up to max
    // double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      // ⭐ Removed fixed height constraint. Let children define height.
      // constraints: BoxConstraints(maxHeight: screenHeight), // Option if you want to cap it
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 50 : 30,
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 20,
      ),
      color: AppColors.backgroundPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // ⭐ Important: Column takes only necessary height for its children
        mainAxisSize: MainAxisSize.min, // This makes the column shrink-wrap its content
        children: [
          // Section Title
          Text(
            'My Journey',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 36 : 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          // Reduced margin for the underline
          Container(
            width: isDesktop ? 120 : 80,
            height: 3,
            color: AppColors.accentOrange,
            margin: const EdgeInsets.only(top: 4, bottom: 20), // Reduced bottom margin
          ),
          // Experience Timeline - ⭐ Crucial: No Expanded and No SingleChildScrollView here
          // This allows the column to grow to fit all timeline tiles
          Column(
            children: [
              ExperienceTimelineTile(
                duration: 'Feb 2024 - May 2024',
                title: 'Flutter App Dev Intern',
                company: 'Cody Tech Software House',
                description: 'Gained practical experience building Flutter mobile apps, working on client projects. Strengthened UI/UX, Firebase integration, & debugging skills.',
                certificateImagePath: 'assets/certificates/codytech_certificate.png',
              ),
              ExperienceTimelineTile(
                duration: 'July 2025 - Nov 2025',
                title: 'Flutter App Dev Intern (Ongoing)',
                company: 'Apidcore',
                description: 'Currently enhancing skills in Flutter app development through a real-world project internship.',
                certificateImagePath: 'assets/certificates/apidcore_offer_letter.png',
              ),
              ExperienceTimelineTile(
                duration: 'Sep 2023 - Present',
                title: 'Computer Subject Mentor (Online)',
                company: 'Self-employed',
                description: 'Taught Flutter frontend & Firebase online to students, helping them grasp software dev concepts.',
              ),
            ],
          ),
          // Download Resume Button
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: OutlinedButton.icon(
              onPressed: () async {
                const String resumeUrl = 'assets/ManahilTareen_CV.docx';
                if (await canLaunchUrl(Uri.parse(resumeUrl))) {
                  await launchUrl(Uri.parse(resumeUrl));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch resume: $resumeUrl')),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.accentOrange,
                side: BorderSide(color: AppColors.accentOrange, width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              icon: const Icon(Icons.download),
              label: const Text('Download Resume'),
            ),
          ),
        ],
      ),
    );
  }
}