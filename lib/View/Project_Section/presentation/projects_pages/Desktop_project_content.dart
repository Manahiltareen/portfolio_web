// lib/sections/project_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/Data/models/project_model.dart';


import 'package:portfolio_web/Shared/dimensions/MediaQueries.dart';
import 'package:portfolio_web/Shared/dimensions/app_dimensions.dart';
import 'package:portfolio_web/Shared/dimensions/breakpoints.dart';
import 'package:portfolio_web/core/constants/project_section_data.dart';
import 'package:portfolio_web/core/helpers/Responsive.dart';
import 'package:portfolio_web/core/helpers/responsive_helper.dart'
;import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTablet = Responsive.isTablet(context);
    bool isDesktop = Responsive.isDesktop(context);

    // Determine grid crossAxisCount based on screen size
    int crossAxisCount;
    if (isDesktop) {
      crossAxisCount = 3; // 3 projects per row on desktop
    } else if (isTablet) {
      crossAxisCount = 2; // 2 projects per row on tablet
    } else {
      crossAxisCount = 1; // 1 project per row on mobile
    }

    return Container(
      color: AppColors.backgroundPrimary, // Consistent background
      padding: EdgeInsets.symmetric(
        vertical: GetMediaQuery.getHeigth(context)* 0.1, // Adjust vertical padding
        horizontal: GetMediaQuery.getWidth(context) * 0.1, // Adjust horizontal padding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'MY PROJECTS',
            style: GoogleFonts.poppins(
              color: AppColors.accentOrange,
              fontSize:
              // isDesktop ?
              48 ,
                  // : isTablet ? 36 : 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:GetMediaQuery.getHeigth(context) * 0.05),
          GridView.builder(
            shrinkWrap: true, // Important for GridView inside Column
            physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30, // Spacing between columns
              mainAxisSpacing: 30,  // Spacing between rows
              childAspectRatio: isDesktop ? 0.7 : isTablet ? 1.0 : 0.8, // Adjust aspect ratio for card sizing
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectCard(project: project);
            },
          ),
        ],
      ),
    );
  }
}

// Separate widget for individual project cards
// class ProjectCard extends StatelessWidget {
//   final Project project;
//
//   const ProjectCard({super.key, required this.project});
//
//   @override
//   Widget build(BuildContext context) {
//     // bool isMobile = Responsive.isMobile(context);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.blackText, // Darker background for the card
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             spreadRadius: 5,
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex:
//             // isMobile ? 3 :
//             2, // Image takes more space on mobile
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 project.imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   project.title,
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textPrimary,
//                     fontSize:
//                     // isMobile ? 20 :
//                     22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   project.description,
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textPrimary,
//                     fontSize:
//                     // isMobile ? 14 :
//                     16,
//                   ),
//                   maxLines:
//                   // isMobile ? 3 :
//                   4, // More lines on desktop for description
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 15),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: project.technologies.map((tech) => Chip(
//                     label: Text(
//                       tech,
//                       style: GoogleFonts.poppins(
//                         color: AppColors.textPrimary,
//                         fontSize:
//                         // isMobile ? 10 :
//                         12,
//                       ),
//                     ),
//                     backgroundColor: AppColors.backgroundPrimary,
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   )).toList(),
//                 ),
//                 SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: OutlinedButton.icon(
//                     onPressed: () async {
//                       if (await canLaunchUrl(Uri.parse(project.githubLink))) {
//                         await launchUrl(Uri.parse(project.githubLink));
//                       } else {
//                         // Handle error (e.g., show a snackbar)
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Could not launch ${project.githubLink}')),
//                         );
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: AppColors.textPrimary,
//                       side: BorderSide(color: AppColors.textPrimary, width: 2),
//                       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                       textStyle: GoogleFonts.poppins(fontSize:
//                       // isMobile ? 14 :
//                       16),
//                     ),
//                     icon: Icon(Icons.code), // GitHub icon or similar
//                     label: Text('View Code'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/sections/project_section.dart (continue in this file)


// Make ProjectCard a StatefulWidget to manage hover state
class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context); // Use your Responsive utility

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth transition for hover
        decoration: BoxDecoration(
          color: AppColors.blackText,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovering
              ? [
            BoxShadow(
              color: AppColors.accentOrange.withOpacity(0.2), // Glow on hover
              spreadRadius: 8,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: _isHovering
              ? Border.all(color: AppColors.accentOrange, width: 2) // Border on hover
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 3 : 3, // Image takes more space on mobile
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  widget.project.imageUrl, // Use widget.project
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title, // Use widget.project
                    style: GoogleFonts.poppins(
                      color: AppColors.accentOrange, // Changed to accentOrange for consistency with project section image
                      fontSize: isMobile ? 20 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.project.description, // Use widget.project
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: isMobile ? 14 : 16,
                    ),
                    maxLines: isMobile ? 3 : 4, // More lines on desktop for description
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.technologies.map((tech) => Chip(
                      label: Text(
                        tech,
                        style: GoogleFonts.poppins(
                          color: AppColors.textPrimary,
                          fontSize: isMobile ? 10 : 12,
                        ),
                      ),
                      backgroundColor: AppColors.backgroundPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  // --- GitHub & Live Demo Icons ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // GitHub Icon Button
                      IconButton(
                        icon: const Icon(Icons.code), // Represents code/GitHub
                        color: AppColors.textPrimary, // Icon color
                        onPressed: () async {
                          if (await canLaunchUrl(Uri.parse(widget.project.githubLink))) {
                            await launchUrl(Uri.parse(widget.project.githubLink));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not launch ${widget.project.githubLink}')),
                            );
                          }
                        },
                      ),
                      if (widget.project.liveDemoLink != null && widget.project.liveDemoLink!.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.open_in_new), // Represents external link/live demo
                          color: AppColors.textPrimary,
                          onPressed: () async {
                            if (await canLaunchUrl(Uri.parse(widget.project.liveDemoLink!))) {
                              await launchUrl(Uri.parse(widget.project.liveDemoLink!));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Could not launch ${widget.project.liveDemoLink}')),
                              );
                            }
                          },
                        ),
                      // Spacer to push "View Code" button to the right if icons are on left
                      const Spacer(),
                      // --- "View Code" Button (Remains as is) ---

                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomRight,

                    child: OutlinedButton.icon(
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(widget.project.githubLink))) {
                          await launchUrl(Uri.parse(widget.project.githubLink));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not launch ${widget.project.githubLink}')),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.accentOrange, // Changed to accentOrange
                        side: BorderSide(color: AppColors.accentOrange, width: 2), // Changed to accentOrange
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        textStyle: GoogleFonts.poppins(fontSize: isMobile ? 14 : 16),
                      ),
                      icon: const Icon(Icons.code),
                      label: const Text('View Code'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}