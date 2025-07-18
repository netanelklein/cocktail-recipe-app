import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Input fields with bar aesthetic theme.
///
/// Features:
/// - Consistent styling with bar theme
/// - Copper/bronze accent colors
/// - Validation states and error handling
/// - Multiple input types (text, number, multiline)
class BarTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool required;

  const BarTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.required = false,
  });

  @override
  State<BarTextField> createState() => _BarTextFieldState();
}

class _BarTextFieldState extends State<BarTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) _buildLabel(context),
        _buildTextField(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: widget.label!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          children: [
            if (widget.required)
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.surfaceContainer, colorScheme.surface],
        ),
        borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
        border: Border.all(
          color: _isFocused
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.3),
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          contentPadding: const EdgeInsets.all(16),
          counterStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

/// Dropdown field with bar aesthetic
class BarDropdownField<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<BarDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final bool required;

  const BarDropdownField({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.required = false,
  });

  @override
  State<BarDropdownField<T>> createState() => _BarDropdownFieldState<T>();
}

class _BarDropdownFieldState<T> extends State<BarDropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) _buildLabel(context),
        _buildDropdown(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: widget.label!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          children: [
            if (widget.required)
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.surfaceContainer, colorScheme.surface],
        ),
        borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonFormField<T>(
        value: widget.value,
        onChanged: widget.enabled ? widget.onChanged : null,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        dropdownColor: colorScheme.surfaceContainer,
        items: widget.items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item.value,
                child: Text(item.label),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Dropdown item model
class BarDropdownItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  const BarDropdownItem({required this.value, required this.label, this.icon});
}

/// Switch with bar aesthetic
class BarSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;
  final bool enabled;

  const BarSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.description,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      borderRadius: BorderRadius.circular(AppConstants.standardBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: enabled
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: enabled
                            ? colorScheme.onSurface.withValues(alpha: 0.7)
                            : colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: colorScheme.primary,
              activeTrackColor: colorScheme.primary.withValues(alpha: 0.5),
              inactiveThumbColor: colorScheme.outline,
              inactiveTrackColor: colorScheme.surfaceContainer,
            ),
          ],
        ),
      ),
    );
  }
}
