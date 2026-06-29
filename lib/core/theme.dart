import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBgStart,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.w800,
        color: AppColors.textMainDark,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textMainDark,
        letterSpacing: -1.0,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textMainDark,
        letterSpacing: -0.5,
        height: 1.3,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppColors.textMainDark,
        fontSize: 18,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.textDimDark,
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textMainDark,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBgStart,
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.w800,
        color: AppColors.textMainLight,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textMainLight,
        letterSpacing: -1.0,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textMainLight,
        letterSpacing: -0.5,
        height: 1.3,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppColors.textMainLight,
        fontSize: 18,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.textDimLight,
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: Colors.white,
      onSurface: AppColors.textMainLight,
    ),
  );
}
