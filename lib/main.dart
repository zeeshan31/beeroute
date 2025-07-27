import 'package:flutter/material.dart';
import 'landing_page.dart';

void main() {
  runApp(BeeRouteApp());
}

class BeeRouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(     
      title: 'BeeRoute',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 243, 157, 18),
        scaffoldBackgroundColor: Color.fromARGB(237, 255, 175, 26),
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 243, 157, 18),
          secondary: Color.fromARGB(255, 255, 193, 7),
        ),
      ),
      home: LandingPage(), // New landing page
    );
  }
}
