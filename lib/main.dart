import 'package:flutter/gestures.dart'; // Required for PointerDeviceKind
import 'package:flutter/material.dart';
import 'package:portfolio_web/View/main_web_page/main_web_page.dart';
import 'package:portfolio_web/View/main_web_page/testweb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      // ⭐ Custom Scroll Behavior for Web ⭐
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse, // Enable mouse dragging/scrolling
          PointerDeviceKind.touch, // Keep touch scrolling enabled for mobile
        },
      ),
      home: const HomePage(),
    );
  }
}
