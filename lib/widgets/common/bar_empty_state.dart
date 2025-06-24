import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Empty state widgets with bar aesthetic theme.
///
/// Features:
/// - Consistent empty state design
/// - Customizable icons, titles, and messages
/// - Optional action buttons
/// - Bar-themed styling with copper/bronze accents
class BarEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? customIcon;
  final Color? iconColor;

  const BarEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  });

  const BarEmptyState.noCocktails({
    super.key,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  })  : icon = Icons.local_bar,
        title = 'No Cocktails Found',
        message = 'Try adjusting your filters or search terms to find more cocktails.';

  const BarEmptyState.noIngredients({
    super.key,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  })  : icon = Icons.inventory_2,
        title = 'No Ingredients Yet',
        message = 'Add ingredients to your inventory to discover cocktails you can make.';

  const BarEmptyState.noFavorites({
    super.key,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  })  : icon = Icons.favorite_border,
        title = 'No Favorites',
        message = 'Mark cocktails as favorites to see them here.';

  const BarEmptyState.noResults({
    super.key,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  })  : icon = Icons.search_off,
        title = 'No Results',
        message = 'Your search didn\'t match any cocktails. Try different keywords.';

  const BarEmptyState.offline({
    super.key,
    this.actionText,
    this.onAction,
    this.customIcon,
    this.iconColor,
  })  : icon = Icons.wifi_off,
        title = 'You\'re Offline',
        message = 'Check your internet connection and try again.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(context),
              const SizedBox(height: 24),
              _buildTitle(context),
              const SizedBox(height: 12),
              _buildMessage(context),
              if (actionText != null && onAction != null) ...[
                const SizedBox(height: 32),
                _buildActionButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    if (customIcon != null) {
      return customIcon!;
    }

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            (iconColor ?? colorScheme.primary).withValues(alpha: 0.2),
            (iconColor ?? colorScheme.primary).withValues(alpha: 0.1),
            Colors.transparent,
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
      child: Icon(
        icon,
        size: 40,
        color: iconColor ?? colorScheme.primary,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
      textAlign: TextAlign.center,
      maxLines: 3,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
          ),
        ),
        child: Text(
          actionText!,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Compact empty state for smaller spaces
class BarEmptyStateCompact extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color? iconColor;
  final double iconSize;

  const BarEmptyStateCompact({
    super.key,
    required this.icon,
    required this.message,
    this.iconColor,
    this.iconSize = 32,
  });

  const BarEmptyStateCompact.noItems({
    super.key,
    this.iconColor,
    this.iconSize = 32,
  })  : icon = Icons.inbox,
        message = 'No items to display';

  const BarEmptyStateCompact.noResults({
    super.key,
    this.iconColor,
    this.iconSize = 32,
  })  : icon = Icons.search_off,
        message = 'No results found';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Empty state for lists with animated appearance
class BarEmptyStateAnimated extends StatefulWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;
  final Duration animationDuration;

  const BarEmptyStateAnimated({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<BarEmptyStateAnimated> createState() => _BarEmptyStateAnimatedState();
}

class _BarEmptyStateAnimatedState extends State<BarEmptyStateAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: BarEmptyState(
          icon: widget.icon,
          title: widget.title,
          message: widget.message,
          actionText: widget.actionText,
          onAction: widget.onAction,
        ),
      ),
    );
  }
}
