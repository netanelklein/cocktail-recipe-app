import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Button styles following the dark bar aesthetic.
/// 
/// Provides three button variants:
/// - Primary: Gold gradient with shadows for main actions
/// - Secondary: Gold outline for secondary actions  
/// - Tertiary: Copper text for subtle actions
class BarButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BarButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const BarButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = BarButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  const BarButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : type = BarButtonType.primary;

  const BarButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : type = BarButtonType.secondary;

  const BarButton.tertiary({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : type = BarButtonType.tertiary;

  @override
  Widget build(BuildContext context) {
    if (type == BarButtonType.tertiary) {
      return _buildTextButton(context);
    } else if (type == BarButtonType.secondary) {
      return _buildOutlinedButton(context);
    } else {
      return _buildElevatedButton(context);
    }
  }

  Widget _buildElevatedButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(
            width ?? AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 2),
          minimumSize: Size(
            width ?? AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          minimumSize: Size(
            width ?? AppConstants.minTouchTarget,
            AppConstants.minTouchTarget,
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}

enum BarButtonType {
  primary,
  secondary,
  tertiary,
}
