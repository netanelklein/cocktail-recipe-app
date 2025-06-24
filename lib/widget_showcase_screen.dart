import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/common/common.dart';
import '../widgets/theme_switcher.dart';
import '../widgets/cocktail_glass_rating.dart';

/// Widget showcase screen to display all bar-themed widgets
/// for development and testing purposes.
class WidgetShowcaseScreen extends ConsumerStatefulWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  ConsumerState<WidgetShowcaseScreen> createState() => _WidgetShowcaseScreenState();
}

class _WidgetShowcaseScreenState extends ConsumerState<WidgetShowcaseScreen> {
  double _rating = 4.5;
  bool _switchValue = true;
  String? _dropdownValue = 'option1';
  bool _isLoading = false;
  final List<String> _selectedIngredients = ['Vodka', 'Lime Juice'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Showcase'),
      ),
      body: BarLoadingOverlay(
        isLoading: _isLoading,
        message: 'Loading widgets...',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Theme Switcher', const ThemeSwitcher()),
              _buildSection('Buttons', _buildButtons()),
              _buildSection('Cards', _buildCards()),
              _buildSection('Search & Input', _buildInputs()),
              _buildSection('Chips', _buildChips()),
              _buildSection('Ratings', _buildRatings()),
              _buildSection('Loading States', _buildLoadingStates()),
              _buildSection('Empty States', _buildEmptyStates()),
              _buildSection('Modals', _buildModals()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        content,
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BarButton.primary(
                text: 'Primary Button',
                onPressed: () => _showSnackBar('Primary pressed'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BarButton.secondary(
                text: 'Secondary',
                onPressed: () => _showSnackBar('Secondary pressed'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: BarButton.tertiary(
                text: 'Tertiary Button',
                onPressed: () => _showSnackBar('Tertiary pressed'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BarButton.primary(
                text: 'Loading',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCards() {
    return Column(
      children: [
        BarCard(
          title: 'Mojito',
          subtitle: 'Fresh mint and lime cocktail',
          imageUrl: null, // Would normally have an image
          rating: 4.8,
          tags: ['Refreshing', 'Minty', 'Classic'],
          isSelected: false,
          onTap: () => _showSnackBar('Mojito tapped'),
        ),
        const SizedBox(height: 12),
        BarCard(
          title: 'Old Fashioned',
          subtitle: 'Whiskey-based classic',
          rating: 4.6,
          missingIngredients: 1,
          onTap: () => _showSnackBar('Old Fashioned tapped'),
        ),
      ],
    );
  }

  Widget _buildInputs() {
    return Column(
      children: [
        BarSearchField(
          hintText: 'Search cocktails...',
          onChanged: (value) => setState(() {}),
          suggestions: const ['Mojito', 'Margarita', 'Manhattan', 'Martini'],
        ),
        const SizedBox(height: 16),
        BarTextField(
          label: 'Cocktail Name',
          hint: 'Enter cocktail name',
          required: true,
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 16),
        BarDropdownField<String>(
          label: 'Category',
          hint: 'Select category',
          value: _dropdownValue,
          items: const [
            BarDropdownItem(value: 'option1', label: 'Classic Cocktails'),
            BarDropdownItem(value: 'option2', label: 'Modern Mixology'),
            BarDropdownItem(value: 'option3', label: 'Tropical Drinks'),
          ],
          onChanged: (value) => setState(() => _dropdownValue = value),
        ),
        const SizedBox(height: 16),
        BarSwitch(
          value: _switchValue,
          label: 'Enable Notifications',
          description: 'Get notified about new cocktails',
          onChanged: (value) => setState(() => _switchValue = value),
        ),
      ],
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        BarChip.ingredient(
          label: 'Vodka',
          isSelected: _selectedIngredients.contains('Vodka'),
          isAvailable: true,
          onTap: () => _toggleIngredient('Vodka'),
        ),
        BarChip.ingredient(
          label: 'Gin',
          isSelected: _selectedIngredients.contains('Gin'),
          isAvailable: false,
          onTap: () => _toggleIngredient('Gin'),
        ),
        const BarChip(
          label: 'Sweet',
          type: BarChipType.category,
          icon: Icons.favorite,
        ),
        const BarChip(
          label: 'Strong',
          type: BarChipType.filter,
          icon: Icons.local_fire_department,
        ),
      ],
    );
  }

  Widget _buildRatings() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Interactive Rating:',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 16),
            BarRating.interactive(
              rating: _rating,
              onRatingChanged: (rating) => setState(() => _rating = rating),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Read-only Rating:',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 16),
            const BarRating.readOnly(
              rating: 4.3,
              showLabel: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Compact Rating:',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 16),
            const BarRatingCompact(
              rating: 4.7,
              reviewCount: 156,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Cocktail Glass Rating:',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 16),
            CocktailGlassRating.interactive(
              rating: _rating,
              onRatingChanged: (rating) => setState(() => _rating = rating),
              glassType: CocktailGlassType.martini,
            ),
          ],
        ),
        const SizedBox(height: 16),
        BarRatingSummary(
          averageRating: 4.2,
          totalReviews: 234,
          ratingBreakdown: const {
            5: 120,
            4: 78,
            3: 25,
            2: 8,
            1: 3,
          },
          onViewAllReviews: () => _showSnackBar('View all reviews'),
        ),
      ],
    );
  }

  Widget _buildLoadingStates() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Spinner',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 8),
                const BarLoading.spinner(),
              ],
            ),
            Column(
              children: [
                Text(
                  'Pulse',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 8),
                const BarLoading.pulse(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Shimmer',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        const BarLoading.shimmer(size: 300),
        const SizedBox(height: 16),
        BarButton.secondary(
          text: 'Toggle Loading Overlay',
          onPressed: () => setState(() => _isLoading = !_isLoading),
        ),
      ],
    );
  }

  Widget _buildEmptyStates() {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const BarEmptyState.noCocktails(
            actionText: 'Browse Cocktails',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const BarEmptyStateCompact.noResults(),
        ),
      ],
    );
  }

  Widget _buildModals() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BarButton.secondary(
                text: 'Show Dialog',
                onPressed: _showDialog,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BarButton.secondary(
                text: 'Show Bottom Sheet',
                onPressed: _showBottomSheet,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BarButton.secondary(
          text: 'Show Confirmation',
          onPressed: _showConfirmation,
        ),
      ],
    );
  }

  void _toggleIngredient(String ingredient) {
    setState(() {
      if (_selectedIngredients.contains(ingredient)) {
        _selectedIngredients.remove(ingredient);
      } else {
        _selectedIngredients.add(ingredient);
      }
    });
  }

  void _showSnackBar(String message) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showDialog() {
    BarModal.showDialog(
      context,
      title: 'Sample Dialog',
      child: Builder(
        builder: (context) => Text(
          'This is a sample dialog with bar theme styling.',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        BarButton.primary(
          text: 'OK',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showBottomSheet() {
    BarModal.showBottomSheet(
      context,
      title: 'Sample Bottom Sheet',
      child: Builder(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.local_bar, color: Theme.of(context).colorScheme.secondary),
              title: Text('Option 1', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            ),
            ListTile(
              leading: Icon(Icons.wine_bar, color: Theme.of(context).colorScheme.secondary),
              title: Text('Option 2', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            ),
          ],
        ),
      ),
      actions: [
        BarButton.primary(
          text: 'Done',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showConfirmation() {
    BarModal.showConfirmation(
      context,
      title: 'Delete Cocktail',
      message: 'Are you sure you want to delete this cocktail? This action cannot be undone.',
      confirmText: 'Delete',
      isDestructive: true,
    ).then((confirmed) {
      if (confirmed == true) {
        _showSnackBar('Cocktail deleted');
      }
    });
  }
}
