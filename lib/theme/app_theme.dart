import 'package:flutter/material.dart';

// Theme mode enum
enum AppThemeMode {
  dark,
  light,
  oled,
}

class AppTheme {
  
  // Current theme mode
  static AppThemeMode currentTheme = AppThemeMode.dark;
  
  // Theme change listeners
  static final List<Function()> _themeChangeListeners = [];
  
  // Add a listener for theme changes
  static void addThemeChangeListener(Function() listener) {
    _themeChangeListeners.add(listener);
  }
  
  // Remove a listener
  static void removeThemeChangeListener(Function() listener) {
    _themeChangeListeners.remove(listener);
  }
  
  // Notify all listeners of theme change
  static void notifyThemeChangeListeners() {
    for (var listener in _themeChangeListeners) {
      listener();
    }
  }
  
  // Primary colors - Dark Theme
  static const Color primaryDark = Color(0xFF1A1A2E); // Dark blue/purple background
  static const Color primaryMedium = Color(0xFF2A2A40); // Medium dark for cards
  static const Color primaryLight = Color(0xFF3A3A50); // Lighter dark for inputs
  
  // Primary colors - Light Theme
  static const Color primaryLightBg = Color(0xFFF5F5F7); // Light background
  static const Color primaryLightMedium = Color(0xFFE5E5E9); // Medium light for cards
  static const Color primaryLightLight = Color(0xFFD5D5D9); // Lighter light for inputs
  
  // Primary colors - OLED Theme
  static const Color primaryOled = Colors.black; // Pure black background
  static const Color primaryOledMedium = Color(0xFF121212); // Very dark for cards
  static const Color primaryOledLight = Color(0xFF1E1E1E); // Slightly lighter for inputs
  
  // Accent colors
  static const Color accentBlue = Color(0xFF3498DB); // Blue accent
  static const Color accentPurple = Color(0xFF9B59B6); // Purple accent
  static const Color accentPink = Color(0xFFE91E63); // Pink accent
  static const Color accentOrange = Color(0xFFFF9800); // Orange accent
  static const Color accentGreen = Color(0xFF2ECC71); // Green accent
  
  // Text colors - Dark & OLED
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3); // Light gray
  
  // Text colors - Light
  static const Color textPrimaryLight = Color(0xFF333333);
  static const Color textSecondaryLight = Color(0xFF666666); // Dark gray
  
  // Status colors
  static const Color success = Color(0xFF2ECC71); // Green
  static const Color warning = Color(0xFFF39C12); // Orange
  static const Color error = Color(0xFFE74C3C); // Red
  
  // Get current theme based on setting
  static ThemeData get currentThemeData {
    switch (currentTheme) {
      case AppThemeMode.light:
        return lightTheme;
      case AppThemeMode.oled:
        return oledTheme;
      case AppThemeMode.dark:
      default:
        return darkTheme;
    }
  }
  
  // Create the dark theme data
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
  
  // Create the light theme data
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: primaryLightBg,
    brightness: Brightness.light,
    primaryColor: primaryLightBg,
    colorScheme: const ColorScheme.light(
      primary: primaryLightBg,
      secondary: accentBlue,
      surface: primaryLightMedium,
      background: primaryLightBg,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryLightBg,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimaryLight),
      titleTextStyle: TextStyle(color: textPrimaryLight, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    cardTheme: const CardTheme(
      color: primaryLightMedium,
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
      color: textPrimaryLight,
      size: 24,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textPrimaryLight, fontSize: 26, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textPrimaryLight, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textPrimaryLight, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: textPrimaryLight, fontSize: 16),
      bodyMedium: TextStyle(color: textPrimaryLight, fontSize: 14),
      bodySmall: TextStyle(color: textSecondaryLight, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryLightLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: textSecondaryLight),
    ),
  );
  
  // Create the OLED theme data (true black for OLED screens)
  static ThemeData oledTheme = ThemeData(
    scaffoldBackgroundColor: primaryOled,
    brightness: Brightness.dark,
    primaryColor: primaryOled,
    colorScheme: const ColorScheme.dark(
      primary: primaryOled,
      secondary: accentBlue,
      surface: primaryOledMedium,
      background: primaryOled,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryOled,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    cardTheme: const CardTheme(
      color: primaryOledMedium,
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
      fillColor: primaryOledLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: textSecondary),
    ),
  );
}