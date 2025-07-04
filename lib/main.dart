import 'package:flutter/material.dart';
import 'View/Welcome_Screen.dart';
import 'themes/app_theme.dart'; // Adjust the path if needed

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eportal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Apply your custom theme here
      home: const WelcomeScreen(),
    );
  }
}
