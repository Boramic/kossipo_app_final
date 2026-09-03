import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class DropdownField<T> extends StatefulWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final String Function(T) labelBuilder;
  final Function(T)? onChanged;

  final bool enabled;
  final String? errorText;

  const DropdownField({
    super.key,
    required this.items,
    required this.labelBuilder,
    this.value,
    this.onChanged,
    this.hintText = "Select option",
    this.enabled = true,
    this.errorText,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  bool _isFocused = false;
  bool _isOpen = false;

  OverlayEntry? _overlayEntry;

  bool get _isDisabled => !widget.enabled;
  bool get _hasError => widget.errorText != null;

  Color get _borderColor {
    if (_hasError) return AppColors.error;
    if (_isFocused || _isOpen) return AppColors.primaryGreen;
    if (_isDisabled) return AppColors.disabled;
    return AppColors.border;
  }

  List<BoxShadow>? get _shadow {
    if (_isDisabled) return null;

    if (_isFocused || _isOpen) {
      return [
        BoxShadow(
          color: AppColors.accentGreen.withOpacity(0.18),
          blurRadius: 14,
          spreadRadius: -2,
        ),
      ];
    }
    return null;
  }

  void _toggleDropdown() {
    if (_isDisabled) return;

    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),

            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 6,
              width: size.width,

              child: Material(
                elevation: 8,
                borderRadius: AppRadius.input,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.input,
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items.map((item) {
                      final label = widget.labelBuilder(item);

                      return InkWell(
                        onTap: () {
                          widget.onChanged?.call(item);
                          _removeOverlay();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    setState(() {
      _isOpen = true;
      _isFocused = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    setState(() {
      _isOpen = false;
      _isFocused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel = widget.value != null
        ? widget.labelBuilder(widget.value as T)
        : null;

    return Focus(
      onFocusChange: (focus) {
        if (!_isDisabled) {
          setState(() => _isFocused = focus);
        }
      },
      child: Opacity(
        opacity: _isDisabled ? 0.6 : 1,
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            decoration: BoxDecoration(
              color: AppColors.secondaryGreen,
              borderRadius: AppRadius.input,
              border: Border.all(
                color: _borderColor,
                width: 1.2,
              ),
              boxShadow: _shadow,
            ),

            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedLabel ?? widget.hintText,
                    style: TextStyle(
                      color: selectedLabel == null
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),

                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _isOpen ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: _isDisabled
                        ? AppColors.disabled
                        : AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}