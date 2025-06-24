import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Cocktail-themed color palettes and theme configurations for the Cocktailian app.
/// Each theme is designed around cocktail inspirations with carefully curated colors.

class CocktailThemes {
  // 1. Midnight Martini Theme 🌙
  static const Color midnightSurface = Color(0xFF0A0E1A);
  static const Color midnightContainer = Color(0xFF1A1F2E);
  static const Color midnightCard = Color(0xFF2A3142);
  static const Color midnightPrimary = Color(0xFFFFD700);
  static const Color midnightSecondary = Color(0xFF4A90E2);
  static const Color midnightAccent = Color(0xFF22C55E); // Green for success
  static const Color midnightOnSurface = Color(0xFFFFFFFF);
  static const Color midnightOnPrimary = Color(0xFF000000);

  static const ColorScheme midnightColorScheme = ColorScheme.dark(
    surface: midnightSurface,
    onSurface: midnightOnSurface,
    surfaceContainer: midnightContainer,
    surfaceContainerHighest: midnightCard,
    primary: midnightPrimary,
    onPrimary: midnightOnPrimary,
    secondary: midnightSecondary,
    onSecondary: Colors.white,
    tertiary: midnightAccent,
    onTertiary: Colors.white,
    error: Color(0xFFFF6B6B), // Red for errors
    onError: Colors.white,
    outline: Color(0xFF4A5568),
    shadow: Color(0xFF000000),
  );

  // 2. Whiskey Barrel Theme 🥃
  static const Color whiskeySurface = Color(0xFF1A0F0A);
  static const Color whiskeyContainer = Color(0xFF2D1B13);
  static const Color whiskeyCard = Color(0xFF3D2B1F);
  static const Color whiskeyPrimary = Color(0xFFD4A574);
  static const Color whiskeySecondary = Color(0xFF8B4513);
  static const Color whiskeyAccent = Color(0xFF4CAF50); // Green for success
  static const Color whiskeyOnSurface = Color(0xFFFFFFFF);
  static const Color whiskeyOnPrimary = Color(0xFF000000);

  static const ColorScheme whiskeyColorScheme = ColorScheme.dark(
    surface: whiskeySurface,
    onSurface: whiskeyOnSurface,
    surfaceContainer: whiskeyContainer,
    surfaceContainerHighest: whiskeyCard,
    primary: whiskeyPrimary,
    onPrimary: whiskeyOnPrimary,
    secondary: whiskeySecondary,
    onSecondary: Colors.white,
    tertiary: whiskeyAccent,
    onTertiary: Colors.white,
    error: Color(0xFFD2691E), // Orange-red for errors
    onError: Colors.white,
    outline: Color(0xFF5D4037),
    shadow: Color(0xFF000000),
  );

  // 3. Neon Nights Theme 🌃

  static const Color neonSurface = Color(0xFF0D0D0D);
  static const Color neonContainer = Color(0xFF1A1A1A);
  static const Color neonCard = Color(0xFF2D2D2D);
  static const Color neonPrimary = Color(0xFF00FFFF);
  static const Color neonSecondary = Color(0xFFFF00FF);
  static const Color neonAccent = Color(0xFF00FF00);
  static const Color neonOnSurface = Color(0xFFFFFFFF);
  static const Color neonOnPrimary = Color(0xFF000000);

  static const ColorScheme neonColorScheme = ColorScheme.dark(
    surface: neonSurface,
    onSurface: neonOnSurface,
    surfaceContainer: neonContainer,
    surfaceContainerHighest: neonCard,
    primary: neonPrimary,
    onPrimary: neonOnPrimary,
    secondary: neonSecondary,
    onSecondary: Colors.white,
    tertiary: neonAccent,
    onTertiary: Colors.black,
    error: Color(0xFFFF073A),
    onError: Colors.white,
    outline: Color(0xFF444444),
    shadow: Color(0xFF000000),
  );

  // 4. Forest Gin Theme 🌲
  static const Color forestSurface = Color(0xFF0F1419);
  static const Color forestContainer = Color(0xFF1A2328);
  static const Color forestCard = Color(0xFF2A3439);
  static const Color forestPrimary = Color(0xFF4CAF50);
  static const Color forestSecondary = Color(0xFF2E8B57);
  static const Color forestAccent = Color(0xFFFFA726);
  static const Color forestOnSurface = Color(0xFFFFFFFF);
  static const Color forestOnPrimary = Color(0xFFFFFFFF);

  static const ColorScheme forestColorScheme = ColorScheme.dark(
    surface: forestSurface,
    onSurface: forestOnSurface,
    surfaceContainer: forestContainer,
    surfaceContainerHighest: forestCard,
    primary: forestPrimary,
    onPrimary: forestOnPrimary,
    secondary: forestSecondary,
    onSecondary: Colors.white,
    tertiary: forestAccent,
    onTertiary: Colors.black,
    error: Color(0xFFE57373),
    onError: Colors.white,
    outline: Color(0xFF4A5A4A),
    shadow: Color(0xFF000000),
  );

  /// Creates a cocktail-themed ThemeData from a ColorScheme
  static ThemeData createCocktailTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),

      // Card Theme - More rounded
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Increased from 16
        ),
      ),

      // Button Themes - More rounded
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: colorScheme.onSurface),
        headlineMedium: TextStyle(color: colorScheme.onSurface),
        headlineSmall: TextStyle(color: colorScheme.onSurface),
        bodyLarge: TextStyle(color: colorScheme.onSurface),
        bodyMedium: TextStyle(color: colorScheme.onSurface),
        bodySmall: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.5),
        type: BottomNavigationBarType.fixed,
      ),

      // Input Decoration - More rounded
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),

      // Chip Theme - More rounded
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primary,
        deleteIconColor: colorScheme.onSurface.withValues(alpha: 0.6),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.standardBorderRadius,
          ), // Very rounded chips
        ),
      ),
    );
  }

  // Pre-built themes
  static final ThemeData midnightMartini = createCocktailTheme(
    midnightColorScheme,
  );
  static final ThemeData whiskeyBarrel = createCocktailTheme(
    whiskeyColorScheme,
  );
  static final ThemeData neonNights = createCocktailTheme(neonColorScheme);
  static final ThemeData forestGin = createCocktailTheme(forestColorScheme);

  /// Available themes list for theme switching
  static final List<CocktailThemeData> availableThemes = [
    CocktailThemeData(
      name: 'Midnight Martini',
      description: 'Sophisticated dark palette with gold accents',
      emoji: '🌙',
      themeData: midnightMartini,
      colorScheme: midnightColorScheme,
    ),
    CocktailThemeData(
      name: 'Whiskey Barrel',
      description: 'Warm, rich tones inspired by aged spirits',
      emoji: '🥃',
      themeData: whiskeyBarrel,
      colorScheme: whiskeyColorScheme,
    ),
    CocktailThemeData(
      name: 'Neon Nights',
      description: 'Vibrant cyberpunk-inspired palette',
      emoji: '🌃',
      themeData: neonNights,
      colorScheme: neonColorScheme,
    ),
    CocktailThemeData(
      name: 'Forest Gin',
      description: 'Natural, botanical-inspired palette',
      emoji: '🌲',
      themeData: forestGin,
      colorScheme: forestColorScheme,
    ),
  ];
}

/// Data class for theme information
class CocktailThemeData {
  final String name;
  final String description;
  final String emoji;
  final ThemeData themeData;
  final ColorScheme colorScheme;

  const CocktailThemeData({
    required this.name,
    required this.description,
    required this.emoji,
    required this.themeData,
    required this.colorScheme,
  });
}

/// Gradient helpers for cocktail cards
class CocktailGradients {
  static const LinearGradient midnightGradient = LinearGradient(
    colors: [Color(0xFF0A0E1A), Color(0xFF1A1F2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient whiskeyGradient = LinearGradient(
    colors: [Color(0xFF1A0F0A), Color(0xFF2D1B13)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient forestGradient = LinearGradient(
    colors: [Color(0xFF0F1419), Color(0xFF1A2328)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Get gradient for current theme
  static LinearGradient getGradientForTheme(String themeName) {
    switch (themeName) {
      case 'Midnight Martini':
        return midnightGradient;
      case 'Whiskey Barrel':
        return whiskeyGradient;
      case 'Neon Nights':
        return neonGradient;
      case 'Forest Gin':
        return forestGradient;
      default:
        return midnightGradient;
    }
  }
}
