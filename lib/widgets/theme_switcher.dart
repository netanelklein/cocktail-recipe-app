import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/themes/cocktail_themes.dart';
import '../providers/theme_provider.dart';

/// A widget that allows users to switch between available themes
class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Theme Switcher',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Current: ${currentTheme.emoji} ${currentTheme.name}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CocktailThemes.availableThemes.map((theme) {
                final isSelected = theme.name == currentTheme.name;
                return _ThemeChip(
                  theme: theme,
                  isSelected: isSelected,
                  onTap: () {
                    ref.read(themeProvider.notifier).setTheme(theme);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(themeProvider.notifier).cycleToNextTheme();
                    },
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Next Theme'),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    _showThemePreview(context, currentTheme);
                  },
                  child: const Text('Preview'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showThemePreview(BuildContext context, CocktailThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${theme.emoji} ${theme.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(theme.description),
            const SizedBox(height: 16),
            Text(
              'Color Palette:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            _ColorPalette(colorScheme: theme.colorScheme),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ThemeChip extends StatelessWidget {
  const _ThemeChip({
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  final CocktailThemeData theme;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primary.withValues(alpha: 0.8)
              : theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              theme.emoji,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 4),
            Text(
              theme.name,
              style: TextStyle(
                color: isSelected 
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorPalette extends StatelessWidget {
  const _ColorPalette({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final colors = [
      ('Primary', colorScheme.primary),
      ('Secondary', colorScheme.secondary),
      ('Tertiary', colorScheme.tertiary),
      ('Surface', colorScheme.surface),
      ('Container', colorScheme.surfaceContainer),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((colorInfo) {
        return Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorInfo.$2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              colorInfo.$1,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}
