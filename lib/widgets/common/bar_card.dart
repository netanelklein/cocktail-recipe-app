import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Cocktail card with dark bar aesthetic.
/// 
/// Features:
/// - Dark gradient background
/// - Gold border on selection
/// - Rating display with gold stars
/// - Status badges (ready/missing ingredients)
/// - Hover lift effect with shadows
/// - Missing ingredient highlighting
class BarCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double? rating;
  final int? missingIngredients;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? trailing;
  final List<String>? tags;

  const BarCard({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.rating,
    this.missingIngredients,
    this.isSelected = false,
    this.onTap,
    this.trailing,
    this.tags,
  });

  @override
  State<BarCard> createState() => _BarCardState();
}

class _BarCardState extends State<BarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.fastAnimationMs),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.surfaceContainer,
                      colorScheme.surfaceContainerHighest,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    AppConstants.standardBorderRadius,
                  ),
                  border: widget.isSelected
                      ? Border.all(
                          color: colorScheme.primary,
                          width: 2,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.3),
                      blurRadius: _isHovered ? 12 : 6,
                      offset: Offset(0, _isHovered ? 6 : 3),
                    ),
                    if (widget.isSelected)
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppConstants.standardBorderRadius,
                  ),
                  child: _buildCardContent(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.imageUrl != null) _buildImageSection(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              if (widget.subtitle != null) ...[
                const SizedBox(height: 4),
                _buildSubtitle(),
              ],
              if (widget.rating != null) ...[
                const SizedBox(height: 8),
                _buildRating(),
              ],
              if (widget.missingIngredients != null) ...[
                const SizedBox(height: 8),
                _buildMissingIngredients(),
              ],
              if (widget.tags != null && widget.tags!.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildTags(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        image: widget.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(widget.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: widget.imageUrl == null
          ? Icon(
              Icons.local_bar,
              size: 48,
              color: Theme.of(context).colorScheme.secondary,
            )
          : null,
    );
  }

  Widget _buildHeader() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.trailing != null) ...[
          const SizedBox(width: 8),
          widget.trailing!,
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Text(
      widget.subtitle!,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRating() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            Icons.star,
            size: 16,
            color: index < (widget.rating?.floor() ?? 0)
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.3),
          );
        }),
        const SizedBox(width: 8),
        Text(
          widget.rating!.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildMissingIngredients() {
    final colorScheme = Theme.of(context).colorScheme;
    
    if (widget.missingIngredients == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: colorScheme.onTertiary,
            ),
            const SizedBox(width: 4),
            Text(
              'Can Make Now',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onTertiary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.remove_circle,
              size: 16,
              color: colorScheme.onError,
            ),
            const SizedBox(width: 4),
            Text(
              '${widget.missingIngredients} missing',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onError,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTags() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widget.tags!
          .take(3)
          .map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  tag,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontSize: 10,
                      ),
                ),
              ))
          .toList(),
    );
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
