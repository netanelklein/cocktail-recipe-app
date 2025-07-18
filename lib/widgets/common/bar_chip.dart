import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Ingredient chip with copper/bronze gradient and glow effects.
///
/// Features:
/// - Copper/bronze gradient backgrounds
/// - Hover effects with glow
/// - Remove functionality with animation
/// - Category-based color variations
/// - Available/missing status colors
class BarChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final BarChipType type;
  final IconData? icon;

  const BarChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.isAvailable = true,
    this.onTap,
    this.onDeleted,
    this.type = BarChipType.ingredient,
    this.icon,
  });

  const BarChip.ingredient({
    super.key,
    required this.label,
    this.isSelected = false,
    this.isAvailable = true,
    this.onTap,
    this.onDeleted,
    this.icon,
  }) : type = BarChipType.ingredient;

  const BarChip.category({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
  }) : type = BarChipType.category,
       isAvailable = true,
       onDeleted = null;

  const BarChip.filter({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.onDeleted,
    this.icon,
  }) : type = BarChipType.filter,
       isAvailable = true;

  @override
  State<BarChip> createState() => _BarChipState();
}

class _BarChipState extends State<BarChip> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.fastAnimationMs),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: _getGradient(),
                  borderRadius: BorderRadius.circular(
                    AppConstants.standardBorderRadius,
                  ),
                  border: widget.isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: _getGlowColor().withValues(
                        alpha:
                            (0.3 * _glowAnimation.value) +
                            (_isHovered ? 0.1 : 0.0),
                      ),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.shadow.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 16, color: _getTextColor()),
                      const SizedBox(width: 6),
                    ],
                    if (!widget.isAvailable &&
                        widget.type == BarChipType.ingredient)
                      Icon(
                        Icons.remove_circle,
                        size: 16,
                        color: _getTextColor(),
                      ),
                    if (!widget.isAvailable &&
                        widget.type == BarChipType.ingredient)
                      const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          color: _getTextColor(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.onDeleted != null) ...[
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: widget.onDeleted,
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: _getTextColor().withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  LinearGradient _getGradient() {
    final colorScheme = Theme.of(context).colorScheme;

    if (!widget.isAvailable && widget.type == BarChipType.ingredient) {
      // Missing ingredient - error gradient
      return LinearGradient(
        colors: [colorScheme.error, colorScheme.error.withValues(alpha: 0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    if (widget.isSelected) {
      // Selected - primary gradient
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.primary.withValues(alpha: 0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    switch (widget.type) {
      case BarChipType.ingredient:
        // Available ingredient - secondary gradient
        return LinearGradient(
          colors: [
            colorScheme.secondary,
            colorScheme.secondary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case BarChipType.category:
        // Category - tertiary gradient
        return LinearGradient(
          colors: [
            colorScheme.tertiary,
            colorScheme.tertiary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case BarChipType.filter:
        // Filter - surface gradient
        return LinearGradient(
          colors: [
            colorScheme.surfaceContainer,
            colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Color _getGlowColor() {
    final colorScheme = Theme.of(context).colorScheme;

    if (!widget.isAvailable && widget.type == BarChipType.ingredient) {
      return colorScheme.error;
    }
    if (widget.isSelected) {
      return colorScheme.primary;
    }
    return colorScheme.secondary;
  }

  Color _getTextColor() {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.type == BarChipType.filter && !widget.isSelected) {
      return colorScheme.onSurface;
    }

    if (widget.isSelected) {
      return colorScheme.onPrimary;
    }

    // For ingredient and category chips, use appropriate contrast color
    if (!widget.isAvailable && widget.type == BarChipType.ingredient) {
      return colorScheme.onError;
    }

    return colorScheme.onSecondary;
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

enum BarChipType { ingredient, category, filter }
