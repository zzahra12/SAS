import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaPak Bantul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF003566),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003566),
          primary: const Color(0xFF003566),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', 
      ),
      home: const OnboardingScreen(),
    );
  }
}