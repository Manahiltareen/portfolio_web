import 'package:flutter/material.dart';
import 'package:portfolio_web/View/Project_Section/presentation/projects_pages/Desktop_project_content.dart';
import 'package:portfolio_web/View/about/Presentation/About_pages/desktop_about_content.dart';
import 'package:portfolio_web/View/home/presentation/home_screen.dart';
import 'package:portfolio_web/core/helpers/responsive_helper.dart';
import 'package:portfolio_web/core/notifiers/active_section_notifier.dart';


class MainWebPage extends StatefulWidget {
  const MainWebPage({super.key});

  @override
  State<MainWebPage> createState() => _MainWebPageState();
}

class _MainWebPageState extends State<MainWebPage> {
  // 1. Declare and initialize your ActiveSectionNotifier
  late final ActiveSectionNotifier _activeSectionNotifier;
  late final ScrollController _scrollController; // A ScrollController is good practice for SingleChildScrollView

  @override
  void initState() {
    super.initState();
    _activeSectionNotifier = ActiveSectionNotifier(); // Initialize the notifier
    _scrollController = ScrollController();


  }


  @override
  void dispose() {

    _activeSectionNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            NewHeroSectionContent(),

            DesktopAboutContent(activeSectionNotifier: _activeSectionNotifier),
            ProjectSection(),

          ],
        ),
      ),
    );
  }
}