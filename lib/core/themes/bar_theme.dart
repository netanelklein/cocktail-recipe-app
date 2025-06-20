import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Dark sophisticated bar theme for the Cocktailian app.
class BarTheme {
  static ThemeData get darkBarTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFD700), // Gold accent
        secondary: Color(0xFFB87333), // Copper accent
        tertiary: Color(0xFF8B4513), // Saddle brown
        surface: Color(0xFF2D2D2D), // Card background
        onSurface: Color(0xFFFFFFFF), // Primary text
        surfaceContainerHighest: Color(0xFF1A1A1A), // Primary dark
        onSurfaceVariant: Color(0xFFFFFFFF), // Primary text
        error: Color(0xFFEF4444), // Error/missing
      ),

      // Scaffold Theme
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF232323),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: const Color(0xFF2D2D2D),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD700), // Gold
          foregroundColor: const Color(0xFF1A1A1A), // Dark text on gold
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.standardBorderRadius,
            ),
          ),
          minimumSize: const Size(
            AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFFD700), // Gold text
          side: const BorderSide(color: Color(0xFFFFD700)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.standardBorderRadius,
            ),
          ),
          minimumSize: const Size(
            AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFB87333), // Copper
          minimumSize: const Size(
            AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF232323),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
          borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        labelStyle: const TextStyle(color: Color(0xFFCCCCCC)),
        hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
      ),

      // Typography
      textTheme: const TextTheme(
        // Display styles for cocktail names
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
          fontFamily: 'serif', // Elegant serif for cocktail names
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
          fontFamily: 'serif',
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),

        // Title styles
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),

        // Body text
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC)),

        // Label text
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFFCCCCCC),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: Color(0xFFFFD700), // Gold icons
        size: 24,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF232323),
        selectedItemColor: Color(0xFFFFD700), // Gold for selected
        unselectedItemColor: Color(0xFFCCCCCC),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFB87333), // Copper background
        disabledColor: const Color(0xFF333333),
        selectedColor: const Color(0xFFFFD700), // Gold when selected
        secondarySelectedColor: const Color(0xFFFFD700),
        labelStyle: const TextStyle(color: Color(0xFF1A1A1A)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFF1A1A1A)),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFFFD700), // Gold progress
        linearTrackColor: Color(0xFF333333),
        circularTrackColor: Color(0xFF333333),
      ),
    );
  }

  // Custom colors for specific use cases
  static const Color availableIngredient = Color(0xFF22C55E);
  static const Color almostAvailable = Color(0xFFF59E0B);
  static const Color missingIngredient = Color(0xFFEF4444);
  static const Color border = Color(0xFF333333);
  static const Color elevatedSurface = Color(0xFF3A3A3A);
}
