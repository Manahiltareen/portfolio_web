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

    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 70 : 40,
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.15 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'My Journey',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 35 : 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            width: isDesktop ? 100 : 70,
            height: 3,
            color: AppColors.accentOrange,
            margin: const EdgeInsets.only(top: 4, bottom: 40),
          ),
          Column(
            children: [
              // Ensure these are in the correct order for your timeline
              ExperienceTimelineTile(
                duration: 'Feb 2024 - May 2024', // First item in image
                title: 'Flutter App Dev Intern',
                company: 'Cody Tech Software House',
                description: 'Gained practical experience building Flutter mobile apps, working on client projects. Strengthened UI/UX, Firebase integration, & debugging skills.',
                certificateImagePath: 'assets/certificates/codytech_certificate.png',
                // Keep certificateLink null if you only use imagePath for now
              ),
              ExperienceTimelineTile(
                duration: 'July 2025 - Nov 2025', // Second item in image (Ongoing)
                title: 'Flutter App Dev Intern (Ongoing)',
                company: 'Apidcore',
                description: 'Currently enhancing skills in Flutter app development through a real-world project internship.',
                certificateImagePath: 'assets/certificates/apidcore_offer_letter.png',
              ),
              ExperienceTimelineTile(
                duration: 'Sept 2023 - Present', // Third item in image
                title: 'Comp. Subject Mentor (Online)',
                company: 'Self-employed',
                description: 'Taught Flutter frontend & Firebase online to students, helping them grasp software dev concepts.',
                // No certificate for this one based on image
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: OutlinedButton.icon(
              onPressed: () async {
                const String resumeUrl = 'assets/ManahilTareen_CV.docx'; // ⭐ Confirm this path is correct
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
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                textStyle: GoogleFonts.poppins(fontSize: isDesktop ? 14 : 12, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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