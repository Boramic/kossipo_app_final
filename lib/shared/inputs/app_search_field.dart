import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class SearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool enabled;

  const SearchField({
    super.key,
    this.hintText = "Search...",
    this.controller,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _isFocused = false;

  bool get _isDisabled => !widget.enabled;
  bool get _hasText => (widget.controller?.text.isNotEmpty ?? false);

  Color get _borderColor {
    if (_isFocused) return AppColors.primaryGreen;
    if (_isDisabled) return AppColors.disabled;
    return AppColors.border;
  }

  List<BoxShadow>? get _shadow {
    if (_isDisabled) return null;

    if (_isFocused) {
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

  void _clearText() {
    widget.controller?.clear();
    widget.onChanged?.call('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        if (!_isDisabled) {
          setState(() => _isFocused = focus);
        }
      },
      child: Opacity(
        opacity: _isDisabled ? 0.6 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,

          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
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
              // 🔍 SEARCH ICON
              Icon(
                Icons.search,
                color: _isDisabled
                    ? AppColors.disabled
                    : AppColors.primaryGreen,
              ),

              const SizedBox(width: 10),

              // 📝 INPUT
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  enabled: widget.enabled,
                  onChanged: (value) {
                    setState(() {});
                    widget.onChanged?.call(value);
                  },

                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),

                  cursorColor: AppColors.primaryGreen,

                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              // ❌ CLEAR BUTTON
              if (_hasText && !_isDisabled)
                GestureDetector(
                  onTap: _clearText,
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}