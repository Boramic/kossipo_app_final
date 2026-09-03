import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  final bool enabled;
  final String? errorText;

  const AppTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.enabled = true,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocused = false;

  bool get _hasError => widget.errorText != null;
  bool get _isDisabled => !widget.enabled;

  Color get _borderColor {
    if (_hasError) return AppColors.error;
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

          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            enabled: widget.enabled,

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

              errorText: widget.errorText,

              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}