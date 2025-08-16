import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceTimelineTile extends StatefulWidget {
  final String duration;
  final String title;
  final String company;
  final String description;
  final String? certificateImagePath;
  final String? certificateLink;

  const ExperienceTimelineTile({
    super.key,
    required this.duration,
    required this.title,
    required this.company,
    required this.description,
    this.certificateImagePath,
    this.certificateLink,
  });

  @override
  State<ExperienceTimelineTile> createState() => _ExperienceTimelineTileState();
}

class _ExperienceTimelineTileState extends State<ExperienceTimelineTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Column(
            mainAxisSize: MainAxisSize.min, // Keep column compact vertically
            crossAxisAlignment: CrossAxisAlignment.end, // Align duration to the right
            children: [
              // ⭐ Duration text positioned to the left of the line
              Text(
                widget.duration,
                textAlign: TextAlign.right, // Ensures text aligns right if it wraps
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 13 : 11, // Smaller font for dates
                  color: AppColors.paragraphText, // Muted color
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5), // Small space between date and dot

              // Timeline Dot
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.accentOrange,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentOrange.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
              ),
              // Vertical Line (Expanded to fill remaining height)
              Expanded(
                child: Container(
                  width: 2,
                  color: AppColors.textPrimary.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ],
          ),
          // Horizontal space between timeline and card
          const SizedBox(width: 20),

          // Right side: Experience Card (Main Content)
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 25),
                padding: EdgeInsets.symmetric(
                  vertical: isDesktop ? 17 : 10,
                  horizontal: isDesktop ? 20 : 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isHovered
                      ? [
                    BoxShadow(
                      color: AppColors.accentOrange.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                      : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: _isHovered
                      ? Border.all(color: AppColors.accentOrange, width: 2)
                      : Border.all(color: AppColors.backgroundSecondary, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Make card height compact
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 17 : 15,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.company,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 13 : 11,
                        color: AppColors.accentOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop ? 12 : 10, // ⭐ Smaller description font
                        color: AppColors.paragraphText,
                      ),
                      maxLines: 2, // ⭐ Reduced to 2 lines for shorter card height
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.certificateImagePath != null || widget.certificateLink != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0), // Reduced top padding
                        child: Align(
                          alignment: Alignment.bottomRight, // ⭐ Align button to bottom right
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              String? urlToLaunch = widget.certificateLink ?? widget.certificateImagePath;
                              if (urlToLaunch != null && urlToLaunch.isNotEmpty) {
                                if (await canLaunchUrl(Uri.parse(urlToLaunch))) {
                                  await launchUrl(Uri.parse(urlToLaunch));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Could not open credential: $urlToLaunch')),
                                  );
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.accentOrange,
                              side: BorderSide(color: AppColors.accentOrange, width: 1.5),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), // ⭐ Reduced button padding
                              textStyle: GoogleFonts.poppins(fontSize: isDesktop ? 11 : 9), // ⭐ Smaller button text
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            icon: const Icon(Icons.launch, size: 14), // ⭐ Smaller icon
                            label: const Text('View Credential'),
                          ),
                        ),
                      ),
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