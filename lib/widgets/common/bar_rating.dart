import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Rating widget with bar aesthetic theme.
///
/// Features:
/// - Interactive star ratings
/// - Read-only display mode
/// - Customizable colors and sizes
/// - Smooth animations
/// - Bar-themed styling
class BarRating extends StatefulWidget {
  final double rating;
  final int maxRating;
  final double size;
  final ValueChanged<double>? onRatingChanged;
  final bool readOnly;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showLabel;
  final String? label;
  final bool allowHalfRating;

  const BarRating({
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
    this.allowHalfRating = false,
  });

  const BarRating.readOnly({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 20,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = true,
    this.label,
    this.allowHalfRating = true,
  }) : readOnly = true,
       onRatingChanged = null;

  const BarRating.interactive({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.maxRating = 5,
    this.size = 32,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = false,
    this.label,
    this.allowHalfRating = false,
  }) : readOnly = false;

  @override
  State<BarRating> createState() => _BarRatingState();
}

class _BarRatingState extends State<BarRating>
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
      duration: const Duration(milliseconds: AppConstants.fastAnimationMs),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(BarRating oldWidget) {
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(widget.maxRating, (index) => _buildStar(index)),
        if (widget.showLabel) ...[
          const SizedBox(width: 8),
          _buildLabel(context),
        ],
      ],
    );
  }

  Widget _buildStar(int index) {
    final starValue = index + 1;
    final isActive = _getStarActiveState(starValue);
    final isHovered = _hoveredIndex >= index && !widget.readOnly;

    return GestureDetector(
      onTap: widget.readOnly ? null : () => _onStarTapped(starValue.toDouble()),
      child: MouseRegion(
        onEnter: widget.readOnly ? null : (_) => _onStarHover(index),
        onExit: widget.readOnly ? null : (_) => _onStarExit(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isHovered ? _scaleAnimation.value : 1.0,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  _getStarIcon(starValue),
                  size: widget.size,
                  color: isActive
                      ? (widget.activeColor ??
                            Theme.of(context).colorScheme.primary)
                      : (widget.inactiveColor ??
                            Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.3)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final displayRating = _hoveredIndex >= 0 && !widget.readOnly
        ? (_hoveredIndex + 1).toDouble()
        : _currentRating;

    return Text(
      widget.label ?? '${displayRating.toStringAsFixed(1)}/5',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  IconData _getStarIcon(int starValue) {
    if (widget.allowHalfRating) {
      if (_currentRating >= starValue) {
        return Icons.star;
      } else if (_currentRating >= starValue - 0.5) {
        return Icons.star_half;
      } else {
        return Icons.star_border;
      }
    } else {
      return _currentRating >= starValue ? Icons.star : Icons.star_border;
    }
  }

  bool _getStarActiveState(int starValue) {
    if (_hoveredIndex >= 0 && !widget.readOnly) {
      return starValue <= _hoveredIndex + 1;
    }

    if (widget.allowHalfRating) {
      return _currentRating >= starValue - 0.5;
    } else {
      return _currentRating >= starValue;
    }
  }

  void _onStarTapped(double rating) {
    if (widget.readOnly) return;

    setState(() {
      _currentRating = rating;
    });

    widget.onRatingChanged?.call(rating);
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _onStarHover(int index) {
    if (widget.readOnly) return;

    setState(() {
      _hoveredIndex = index;
    });

    if (_hoveredIndex != index) {
      _animationController.forward();
    }
  }

  void _onStarExit() {
    if (widget.readOnly) return;

    setState(() {
      _hoveredIndex = -1;
    });

    _animationController.reverse();
  }
}

/// Compact rating display for cards and lists
class BarRatingCompact extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double size;
  final Color? color;

  const BarRatingCompact({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.size = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: size, color: color ?? colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (reviewCount > 0) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}

/// Rating summary widget with breakdown
class BarRatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingBreakdown;
  final VoidCallback? onViewAllReviews;

  const BarRatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingBreakdown,
    this.onViewAllReviews,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BarRating.readOnly(rating: averageRating, size: 20),
                  Text(
                    '$totalReviews reviews',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: List.generate(
                    5,
                    (index) => _buildRatingBar(context, 5 - index),
                  ),
                ),
              ),
            ],
          ),
          if (onViewAllReviews != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onViewAllReviews,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.standardBorderRadius,
                    ),
                    side: BorderSide(color: colorScheme.primary),
                  ),
                ),
                child: Text(
                  'View All Reviews',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context, int stars) {
    final colorScheme = Theme.of(context).colorScheme;
    final count = ratingBreakdown[stars] ?? 0;
    final percentage = totalReviews > 0 ? count / totalReviews : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.star, size: 12, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: colorScheme.onSurface.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
