import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/View/about/Presentation/Common_widgets/common_about_widgets.dart';

import 'package:portfolio_web/core/constants/about_data.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:portfolio_web/core/theme/app_text_styles.dart';


class DesktopAboutContent extends StatelessWidget {


  const DesktopAboutContent({super.key,

  });
  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.08;
    final double verticalPadding = 80;

    return Container(
      color: AppColors.backgroundPrimary,
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SERVICES",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.accentYellow,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 6),
                HoverText(
                  text:    "What I Am Great At",
                  fontSize:   Responsive.isDesktop(context) ? 30 : 26,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "I am a passionate Flutter Developer, dedicated to crafting beautiful and high-performance mobile applications. My services include custom app development, Firebase integration, and comprehensive app testing",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      color: AppColors.paragraphText,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // --- MODIFIED SECTION: ListView.builder for Service Boxes ---
                GridView.builder(
                  shrinkWrap: true, // Allow the grid to take only as much space as its children need vertically
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: serviceCards.length, // Uses the length of your data list (should be 6)
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Display 3 items per row
                    crossAxisSpacing: 30.0, // Horizontal space between cards
                    mainAxisSpacing: 20.0, // Vertical space between rows
                    childAspectRatio: 1.7, // Adjust this as needed for your card aspect ratio
                    // A value of 1.0 makes items square.
                    // Increase for taller cards, decrease for wider cards.
                  ),
                  itemBuilder: (context, index) {
                    final service = serviceCards[index];
                    return ServiceHoverCard(
                      icon: service.icon,
                      title: service.title,
                      projects: service.projects,
                    );
                  },
                ),
                // --- END MODIFIED SECTION ---



                const SizedBox(height: 30),

                // Statistics Section (remains unchanged)
                Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  alignment: WrapAlignment.center,
                  children: [
                    AnimatedStatisticItem(
                      value: "9+",
                      label: "Years of Experience",
                    ),
                    AnimatedStatisticItem(
                      value: "200+",
                      label: "Satisfied Customers",
                    ),
                    AnimatedStatisticItem(
                      value: "769+",
                      label: "Design Items",
                    ),
                    AnimatedStatisticItem(
                      value: "124+",
                      label: "Clients Served",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(width: 50),
          // SizedBox(
          //   width: 80,
          //   child: buildVerticalSideNavbar(context, activeSectionNotifier: activeSectionNotifier, scrollController: ), // Pass the notifier,
          // ),
        ],
      ),
    );
  }
}