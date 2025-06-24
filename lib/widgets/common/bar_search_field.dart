import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Search field with dark bar aesthetic and autocomplete functionality.
/// 
/// Features:
/// - Dark background with gold focus
/// - Glass effect with subtle shadows
/// - Real-time search indicators
/// - Autocomplete dropdown styling
/// - Ingredient search optimization
class BarSearchField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<String>? suggestions;
  final bool showSuggestions;
  final ValueChanged<String>? onSuggestionSelected;

  const BarSearchField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.suggestions,
    this.showSuggestions = true,
    this.onSuggestionSelected,
  });

  @override
  State<BarSearchField> createState() => _BarSearchFieldState();
}

class _BarSearchFieldState extends State<BarSearchField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredSuggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onChanged: _onTextChanged,
        onFieldSubmitted: widget.onSubmitted,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Search...',
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon ??
              Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          suffixIcon: _buildSuffixIcon(),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (_controller.text.isNotEmpty && !widget.readOnly) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          _controller.clear();
          _onTextChanged('');
        },
      );
    }
    return widget.suffixIcon;
  }

  void _onTextChanged(String value) {
    widget.onChanged?.call(value);
    
    if (widget.suggestions != null && widget.showSuggestions) {
      _updateSuggestions(value);
    }
  }

  void _updateSuggestions(String query) {
    if (query.isEmpty) {
      _hideSuggestions();
      return;
    }

    setState(() {
      _filteredSuggestions = widget.suggestions!
          .where((suggestion) =>
              suggestion.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();
    });

    if (_filteredSuggestions.isNotEmpty) {
      _showSuggestionsOverlay();
    } else {
      _hideSuggestions();
    }
  }

  void _showSuggestionsOverlay() {
    _hideOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: CompositedTransformFollower(
          link: LayerLink(),
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Container(
                  width: 300, // Fixed width for tests
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: _filteredSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _filteredSuggestions[index];
                      return ListTile(
                        dense: true,
                        title: Text(
                          suggestion,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        leading: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 18,
                        ),
                        onTap: () {
                          _selectSuggestion(suggestion);
                        },
                        hoverColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    widget.onSuggestionSelected?.call(suggestion);
    widget.onChanged?.call(suggestion);
    _hideSuggestions();
  }

  void _hideSuggestions() {
    _hideOverlay();
    setState(() {
      _filteredSuggestions.clear();
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      // Delay hiding to allow for suggestion tap
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _hideSuggestions();
        }
      });
    }
  }
}
