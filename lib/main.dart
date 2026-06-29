import 'package:flutter/material.dart';
import 'view/splash/splash_screen.dart';

void main() {
  runApp(const MenuAssistantApp());
}

class MenuAssistantApp extends StatelessWidget {
  const MenuAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XFFC1DBE8),
          primary: const Color(0xFFC1DBE8),
          secondary: const Color(0xFFFFF1B5),
          surface: Colors.white,
          onSurface: const Color(0XFF1D2D44),
        ),
        scaffoldBackgroundColor: const Color(0XFFF8FAFC),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          ),
        ),
      home: const SplashScreen(),
    );
  }
}

