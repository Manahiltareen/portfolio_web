
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildSocialIcon(IconData icon, String url, bool isDesktop) {
  return IconButton(
    icon: FaIcon(icon), // Using FaIcon for Font Awesome icons
    color: AppColors.textPrimary, // Icon color
    iconSize: isDesktop ? 30 : 24, // Responsive icon size
    onPressed: () async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Get.snackbar("error", "oops");
      }
    },
    // Adding a tooltip for better user experience on hover
    tooltip: url.contains('mailto:') ? 'Send Email' : url.split('//').last.split('/').first.replaceAll('www.', ''),
  );
}
