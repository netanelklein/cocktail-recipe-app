import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/themes/cocktail_themes.dart';

/// Theme state provider for managing the current theme
class ThemeNotifier extends StateNotifier<CocktailThemeData> {
  ThemeNotifier() : super(CocktailThemes.availableThemes[0]) {
    _loadTheme();
  }

  static const String _themeKey = 'selected_theme';

  /// Change to a new theme and persist the selection
  Future<void> setTheme(CocktailThemeData theme) async {
    state = theme;
    await _saveTheme(theme.name);
  }

  /// Load the saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeName = prefs.getString(_themeKey);

      if (savedThemeName != null) {
        final theme = CocktailThemes.availableThemes
            .where((theme) => theme.name == savedThemeName)
            .firstOrNull;

        if (theme != null) {
          state = theme;
        }
      }
    } catch (e) {
      // If loading fails, keep the default theme
      debugPrint('Failed to load theme: $e');
    }
  }

  /// Save the current theme to SharedPreferences
  Future<void> _saveTheme(String themeName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeName);
    } catch (e) {
      debugPrint('Failed to save theme: $e');
    }
  }

  /// Get the next theme in the list (for quick switching)
  CocktailThemeData getNextTheme() {
    final currentIndex = CocktailThemes.availableThemes.indexOf(state);
    final nextIndex =
        (currentIndex + 1) % CocktailThemes.availableThemes.length;
    return CocktailThemes.availableThemes[nextIndex];
  }

  /// Cycle to the next theme
  Future<void> cycleToNextTheme() async {
    await setTheme(getNextTheme());
  }
}

/// Provider for the theme notifier
final themeProvider = StateNotifierProvider<ThemeNotifier, CocktailThemeData>(
  (ref) => ThemeNotifier(),
);

/// Provider for the current theme data (convenience)
final currentThemeProvider = Provider<CocktailThemeData>((ref) {
  return ref.watch(themeProvider);
});

/// Provider for the current color scheme (convenience)
final currentColorSchemeProvider = Provider((ref) {
  return ref.watch(themeProvider).colorScheme;
});
