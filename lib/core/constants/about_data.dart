import 'package:flutter/material.dart';
import 'package:portfolio_web/Data/models/service_card_model.dart';


final List<ServiceCard> serviceCards = [
  const ServiceCard(
    icon: Icons.mobile_friendly,
    title: "Flutter",
    projects: 10,
  ),
  const ServiceCard(
    icon: Icons.local_fire_department_rounded,
    title: "Firebase",
    projects: 4,
  ),
  const ServiceCard(
    icon: Icons.search,
    title: "API integration",
    projects: 5,
  ),
  const ServiceCard(
    icon: Icons.code,
    title: "Python",
    projects: 20
  ),

  const ServiceCard(
    icon: Icons.cloud,
    title: "SQflite",
    projects: 95,
  ),
  const ServiceCard(
    icon: Icons.design_services, // Example new icon
    title: "UI/UX Design",
    projects: 180,
  ),
];