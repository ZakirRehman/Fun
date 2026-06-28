import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF6AA9FF);
  static const Color lightBlue = Color(0xFFDCEEFF);
  static const Color background = Color(0xFFF8FBFF);
  static const Color card = Colors.white;
  static const Color text = Color(0xFF222222);
  static const Color border = Color(0xFFE5EEF8);
  static const Color glassBackground = Color(0x99FFFFFF);
}

class AppTheme {
  static ThemeData get light {
    final baseTheme = ThemeData.light();
    
    return baseTheme.copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.text,
          fontWeight: FontWeight.w800,
          fontSize: 64,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 48,
          letterSpacing: -1,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        bodyLarge: GoogleFonts.outfit(
          color: AppColors.text,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: AppColors.text,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.outfit(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
      ),
    );
  }
}

