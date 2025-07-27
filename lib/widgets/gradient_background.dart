import 'package:flutter/material.dart';

// This widget will wrap any content and apply a gradient background
class GradientBackground extends StatelessWidget {
  final Widget child;  // This will be the content of the page (Home, Profile, etc.)

  // Constructor to accept child widget
  GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF39D12),  // Gradient start color
            Color(0xFFFFC107),  // Gradient end color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,  // The content of the page will be placed here
    );
  }
}
