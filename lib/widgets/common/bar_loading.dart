import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Loading indicators with bar aesthetic theme.
///
/// Features:
/// - Copper/bronze gradient animations
/// - Multiple styles: spinner, pulse, shimmer
/// - Customizable size and colors
/// - Smooth animations with bar theme
class BarLoading extends StatefulWidget {
  final BarLoadingType type;
  final double size;
  final Color? color;
  final String? message;

  const BarLoading({
    super.key,
    this.type = BarLoadingType.spinner,
    this.size = 24.0,
    this.color,
    this.message,
  });

  const BarLoading.spinner({
    super.key,
    this.size = 24.0,
    this.color,
    this.message,
  }) : type = BarLoadingType.spinner;

  const BarLoading.pulse({
    super.key,
    this.size = 40.0,
    this.color,
    this.message,
  }) : type = BarLoadingType.pulse;

  const BarLoading.shimmer({
    super.key,
    this.size = 200.0,
    this.color,
    this.message,
  }) : type = BarLoadingType.shimmer;

  @override
  State<BarLoading> createState() => _BarLoadingState();
}

class _BarLoadingState extends State<BarLoading>
    with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    
    _spinController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _startAnimation();
  }

  void _startAnimation() {
    switch (widget.type) {
      case BarLoadingType.spinner:
        _spinController.repeat();
        break;
      case BarLoadingType.pulse:
        _pulseController.repeat(reverse: true);
        break;
      case BarLoadingType.shimmer:
        _shimmerController.repeat();
        break;
    }
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget loadingWidget;
    switch (widget.type) {
      case BarLoadingType.spinner:
        loadingWidget = _buildSpinner();
        break;
      case BarLoadingType.pulse:
        loadingWidget = _buildPulse();
        break;
      case BarLoadingType.shimmer:
        loadingWidget = _buildShimmer();
        break;
    }

    if (widget.message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingWidget,
          const SizedBox(height: 16),
          Text(
            widget.message!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.color ?? colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return loadingWidget;
  }

  Widget _buildSpinner() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return RotationTransition(
      turns: _spinController,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              Colors.transparent,
              widget.color ?? colorScheme.primary,
              widget.color ?? colorScheme.secondary,
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surface,
          ),
        ),
      ),
    );
  }

  Widget _buildPulse() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                (widget.color ?? colorScheme.primary)
                    .withValues(alpha: 0.8 * _pulseController.value),
                (widget.color ?? colorScheme.secondary)
                    .withValues(alpha: 0.4 * _pulseController.value),
                Colors.transparent,
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
          ),
          child: Center(
            child: Container(
              width: widget.size * 0.3,
              height: widget.size * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color ?? colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                colorScheme.surfaceContainer,
                colorScheme.surfaceContainerHighest,
                widget.color ?? colorScheme.primary,
                colorScheme.surfaceContainerHighest,
                colorScheme.surfaceContainer,
              ],
              stops: [
                0.0,
                _shimmerController.value - 0.3,
                _shimmerController.value,
                _shimmerController.value + 0.3,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Types of bar-themed loading indicators
enum BarLoadingType {
  /// Spinning circle with gradient
  spinner,
  
  /// Pulsing circle with glow
  pulse,
  
  /// Shimmer effect for content placeholders
  shimmer,
}

/// Centered loading overlay with optional backdrop
class BarLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final Color? backdropColor;
  final BarLoadingType type;

  const BarLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.backdropColor,
    this.type = BarLoadingType.spinner,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backdropColor ?? colorScheme.shadow.withValues(alpha: 0.5),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: BarLoading(
                  type: type,
                  message: message,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
