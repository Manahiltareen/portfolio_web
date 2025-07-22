import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_web/Data/models/service_card_model.dart';


final List<ServiceCard> serviceCards = [
  const ServiceCard(
    icon: FontAwesomeIcons.flutter,
    title: "Flutter",
    projects: 10,
  ),
  const ServiceCard(
    icon: FontAwesomeIcons.fire,
    title: "Firebase",
    projects: 4,
  ),
  const ServiceCard(
    icon: FontAwesomeIcons.cloud,
    title: "API integration",
    projects: 5,
  ),
  const ServiceCard(
    icon:  FontAwesomeIcons.python,
    title: "Python",
    projects: 20
  ),

  const ServiceCard(
    icon: FontAwesomeIcons.database,
    title: "SQflite",
    projects: 95,
  ),
  const ServiceCard(
    icon: FontAwesomeIcons.creativeCommons, // Example new icon
    title: "UI/UX Design",
    projects: 180,
  ),
];