import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';

class HoverText extends StatefulWidget {
  final String text;
  final double fontSize;

  const HoverText({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.poppins(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color: _isHovering ? AppColors.accentOrange : Colors.white,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
