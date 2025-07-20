import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs (if certificates are online)
import 'package:portfolio_web/core/theme/app_colors.dart'; // Assuming your color palette
// Assuming your responsive utility

class ExperienceTimelineTile extends StatefulWidget {
  final String duration;
  final String title;
  final String company;
  final String description;
  final String? certificateImagePath; // Path to your certificate image asset
  final String? certificateLink; // Optional: A link if certificate is hosted online

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
    bool isDesktop = Responsive.isDesktop(context); // Use your Responsive utility

    return IntrinsicHeight( // Makes children fill available height
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children vertically
        children: [
          // Left side: Duration and Timeline dot/line
          Container(
            width: isDesktop ? MediaQuery.of(context).size.width * 0.12 : MediaQuery.of(context).size.width * 0.25, // Adjust width
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.duration,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 14 : 13,
                    color: AppColors.accentOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.accentOrange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: AppColors.textPrimary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right side: Experience Card
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 25), // Space between cards
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _isHovered
                      ? [
                    BoxShadow(
                      color: AppColors.accentOrange.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                      : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: _isHovered
                      ? Border.all(color: AppColors.accentOrange, width: 2)
                      : Border.all(color: AppColors.backgroundSecondary, width: 2), // Keep a border for smooth transition
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 20 : 18,
                        color: AppColors.accentOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.company,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 16 : 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop ? 14 : 13,
                        color: AppColors.paragraphText,
                      ),
                      maxLines: 4, // Limit description lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.certificateImagePath != null || widget.certificateLink != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            String? urlToLaunch = widget.certificateLink ?? widget.certificateImagePath;
                            if (urlToLaunch != null && urlToLaunch.isNotEmpty) {
                              // If it's a local asset, open it in a new tab (requires special handling for web)
                              // For web, assets can be directly linked if configured, or opened in a new tab.
                              // For demonstration, we'll assume it's a web-accessible path or a direct link.
                              if (await canLaunchUrl(Uri.parse(urlToLaunch))) {
                                await launchUrl(Uri.parse(urlToLaunch));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Could not open certificate: $urlToLaunch')),
                                );
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: BorderSide(color: AppColors.accentOrange, width: 1.5),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            textStyle: GoogleFonts.poppins(fontSize: isDesktop ? 14 : 12),
                          ),
                          icon: const Icon(Icons.picture_as_pdf), // Or Icons.link
                          label: const Text('View Credential'),
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