import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class EmailField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool enabled;

  const EmailField({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  bool _isFocused = false;
  String? _errorText;

  bool get _isDisabled => !widget.enabled;

  // ✅ SIMPLE EMAIL VALIDATION (SAFE + PRACTICAL)
  String? _validateEmail(String value) {
    if (value.isEmpty) return null;

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "Invalid email address";
    }

    return null;
  }

  Color get _borderColor {
    if (_errorText != null) return AppColors.error;
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

  void _onChanged(String value) {
    final error = _validateEmail(value);

    setState(() {
      _errorText = error;
    });

    widget.onChanged?.call(value);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
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
                  Icon(
                    Icons.email_outlined,
                    color: _isDisabled
                        ? AppColors.disabled
                        : AppColors.primaryGreen,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      enabled: widget.enabled,
                      keyboardType: TextInputType.emailAddress,

                      onChanged: _onChanged,

                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),

                      cursorColor: AppColors.primaryGreen,

                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Email address",
                        hintStyle: TextStyle(
                          color: AppColors.textMuted,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ❌ ERROR MESSAGE
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  _errorText!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}