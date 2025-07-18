import 'package:flutter/material.dart';
import 'icons/cocktail_glass_icons.dart';

/// Cocktail glass rating widget using custom glass icons
class CocktailGlassRating extends StatefulWidget {
  final double rating;
  final int maxRating;
  final double size;
  final ValueChanged<double>? onRatingChanged;
  final bool readOnly;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showLabel;
  final String? label;
  final CocktailGlassType glassType;

  const CocktailGlassRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.onRatingChanged,
    this.readOnly = false,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = false,
    this.label,
    this.glassType = CocktailGlassType.martini,
  });

  const CocktailGlassRating.readOnly({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 20,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = true,
    this.label,
    this.glassType = CocktailGlassType.martini,
  }) : readOnly = true,
       onRatingChanged = null;

  const CocktailGlassRating.interactive({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.maxRating = 5,
    this.size = 32,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = false,
    this.label,
    this.glassType = CocktailGlassType.martini,
  }) : readOnly = false;

  @override
  State<CocktailGlassRating> createState() => _CocktailGlassRatingState();
}

class _CocktailGlassRatingState extends State<CocktailGlassRating>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double _currentRating = 0;
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(CocktailGlassRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      setState(() {
        _currentRating = widget.rating;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          widget.maxRating,
          (index) => _buildGlass(index, colorScheme),
        ),
        if (widget.showLabel) ...[
          const SizedBox(width: 8),
          _buildLabel(context),
        ],
      ],
    );
  }

  Widget _buildGlass(int index, ColorScheme colorScheme) {
    final glassValue = index + 1;
    final isActive = _currentRating >= glassValue;
    final isHovered = _hoveredIndex >= index && !widget.readOnly;

    return GestureDetector(
      onTap: widget.readOnly
          ? null
          : () => _onGlassTapped(glassValue.toDouble()),
      child: MouseRegion(
        onEnter: widget.readOnly ? null : (_) => _onGlassHover(index),
        onExit: widget.readOnly ? null : (_) => _onGlassExit(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isHovered ? _scaleAnimation.value : 1.0,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: _buildGlassIcon(
                  isActive,
                  widget.activeColor ?? colorScheme.primary,
                  widget.inactiveColor ??
                      colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlassIcon(bool filled, Color activeColor, Color inactiveColor) {
    final color = filled ? activeColor : inactiveColor;

    switch (widget.glassType) {
      case CocktailGlassType.martini:
        return CocktailGlassIcons.martiniGlass(
          size: widget.size,
          color: color,
          filled: filled,
        );
      case CocktailGlassType.rocks:
        return CocktailGlassIcons.rocksGlass(
          size: widget.size,
          color: color,
          filled: filled,
        );
      case CocktailGlassType.wine:
        return CocktailGlassIcons.wineGlass(
          size: widget.size,
          color: color,
          filled: filled,
        );
      case CocktailGlassType.shot:
        return CocktailGlassIcons.shotGlass(
          size: widget.size,
          color: color,
          filled: filled,
        );
    }
  }

  Widget _buildLabel(BuildContext context) {
    final displayRating = _hoveredIndex >= 0 && !widget.readOnly
        ? (_hoveredIndex + 1).toDouble()
        : _currentRating;

    return Text(
      widget.label ?? '${displayRating.toStringAsFixed(1)}/${widget.maxRating}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _onGlassTapped(double rating) {
    if (widget.readOnly) return;

    setState(() {
      _currentRating = rating;
    });

    widget.onRatingChanged?.call(rating);

    // Trigger animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _onGlassHover(int index) {
    if (widget.readOnly) return;

    setState(() {
      _hoveredIndex = index;
    });

    _animationController.forward();
  }

  void _onGlassExit() {
    if (widget.readOnly) return;

    setState(() {
      _hoveredIndex = -1;
    });

    _animationController.reverse();
  }
}

/// Different types of cocktail glasses for rating
enum CocktailGlassType { martini, rocks, wine, shot }

/// Extension to get display names for glass types
extension CocktailGlassTypeExtension on CocktailGlassType {
  String get displayName {
    switch (this) {
      case CocktailGlassType.martini:
        return 'Martini Glass';
      case CocktailGlassType.rocks:
        return 'Rocks Glass';
      case CocktailGlassType.wine:
        return 'Wine Glass';
      case CocktailGlassType.shot:
        return 'Shot Glass';
    }
  }

  String get emoji {
    switch (this) {
      case CocktailGlassType.martini:
        return '🍸';
      case CocktailGlassType.rocks:
        return '🥃';
      case CocktailGlassType.wine:
        return '🍷';
      case CocktailGlassType.shot:
        return '🥃';
    }
  }
}
