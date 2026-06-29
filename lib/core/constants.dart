import 'package:flutter/material.dart';

class AppColors {
  // Premium Minimal Dark Palette (Linear/Vercel inspired)
  static const Color primary = Color(0xFFEDEDED); // Primary text/icons (almost white)
  static const Color secondary = Color(0xFFA1A1AA); // Secondary text/icons (slate/gray)
  static const Color accent = Color(0xFF0066FF); // Electric blue for primary actions
  
  // Backgrounds
  static const Color darkBgStart = Color(0xFF0A0A0A);
  static const Color darkBgEnd = Color(0xFF0A0A0A);
  static const List<Color> darkGradient = [
    Color(0xFF0A0A0A),
    Color(0xFF0A0A0A),
  ];
  
  // Surface
  static const Color surfaceDark = Color(0xFF141414);
  static const Color borderDark = Color(0x1AFFFFFF); // 10% white

  // We are keeping light variables but focusing on dark theme as requested
  static const Color lightBgStart = Color(0xFFFFFFFF); 
  static const Color lightBgEnd = Color(0xFFFFFFFF);
  static const List<Color> lightGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
  ];
  
  // Text Colors
  static const Color textMainDark = Color(0xFFEDEDED);
  static const Color textDimDark = Color(0xFFA1A1AA);
  
  static const Color textMainLight = Color(0xFF111111);
  static const Color textDimLight = Color(0xFF666666);

  static const Color hireMe = Color(0xFFEDEDED);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double section = 80.0; // Increased for better breathing room
}
