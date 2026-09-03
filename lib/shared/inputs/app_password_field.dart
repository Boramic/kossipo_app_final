import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  final bool enabled;
  final String? errorText;

  const PasswordField({
    super.key,
    this.hintText = "Password",
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.errorText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool _isFocused = false;

  bool get _hasError => widget.errorText != null;
  bool get _isDisabled => !widget.enabled;

  void _toggleVisibility() {
    if (_isDisabled) return;
    setState(() => _obscureText = !_obscureText);
  }

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

          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  enabled: widget.enabled,
                  onChanged: widget.onChanged,

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
                    errorText: widget.errorText,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              GestureDetector(
                onTap: _toggleVisibility,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    key: ValueKey(_obscureText),
                    color: _isDisabled
                        ? AppColors.disabled
                        : AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}