import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color primaryDark = Color(0xFF1A1A2E); // Dark blue/purple background
  static const Color primaryMedium = Color(0xFF2A2A40); // Medium dark for cards
  static const Color primaryLight = Color(0xFF3A3A50); // Lighter dark for inputs
  
  // Accent colors
  static const Color accentBlue = Color(0xFF3498DB); // Blue accent
  static const Color accentPurple = Color(0xFF9B59B6); // Purple accent
  static const Color accentPink = Color(0xFFE91E63); // Pink accent
  static const Color accentOrange = Color(0xFFFF9800); // Orange accent
  static const Color accentGreen = Color(0xFF2ECC71); // Green accent
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3); // Light gray
  
  // Status colors
  static const Color success = Color(0xFF2ECC71); // Green
  static const Color warning = Color(0xFFF39C12); // Orange
  static const Color error = Color(0xFFE74C3C); // Red
  
  // Create the theme data
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primaryDark,
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: accentBlue,
      surface: primaryMedium,
      background: primaryDark,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    cardTheme: const CardTheme(
      color: primaryMedium,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentBlue,
        foregroundColor: textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentBlue,
      ),
    ),
    iconTheme: const IconThemeData(
      color: textPrimary,
      size: 24,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textPrimary, fontSize: 26, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textPrimary, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: textPrimary, fontSize: 14),
      bodySmall: TextStyle(color: textSecondary, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: textSecondary),
    ),
  );
}