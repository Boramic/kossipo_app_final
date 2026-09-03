import 'package:flutter/material.dart';

import '../../core/constants/app_borders.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_elevation.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AppMultilineField extends StatefulWidget {
  final TextEditingController? controller;

  final String? label;

  final String? hintText;

  final String? helperText;

  final String? errorText;

  final bool enabled;

  final bool readOnly;

  final int minLines;

  final int maxLines;

  final int? maxLength;

  final ValueChanged<String>? onChanged;

  const AppMultilineField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.minLines = 4,
    this.maxLines = 8,
    this.maxLength,
    this.onChanged,
  });

  @override
  State<AppMultilineField> createState() =>
      _AppMultilineFieldState();
}

class _AppMultilineFieldState
    extends State<AppMultilineField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (widget.label != null)

          Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.xs,
            ),
            child: Text(
              widget.label!,
              style: AppTextStyles.label(),
            ),
          ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          decoration: BoxDecoration(
            color: hasError
                ? AppColors.inputError
                : AppColors.secondaryGreen,

            borderRadius: AppRadius.input,

            border: Border.all(
              width: AppBorders.normal,
              color: hasError
                  ? AppColors.inputErrorBorder
                  : _focused
                  ? AppColors.inputFocus
                  : AppColors.border,
            ),

            boxShadow: _focused
                ? AppElevation.greenGlow
                : AppElevation.level1,
          ),

          child: Focus(
            onFocusChange: (value) {
              setState(() {
                _focused = value;
              });
            },
            child: TextField(
              controller: widget.controller,

              enabled: widget.enabled,

              readOnly: widget.readOnly,

              onChanged: widget.onChanged,

              minLines: widget.minLines,

              maxLines: widget.maxLines,

              maxLength: widget.maxLength,

              cursorColor: AppColors.primary,

              style: AppTextStyles.body(),

              decoration: InputDecoration(
                hintText: widget.hintText,

                hintStyle: AppTextStyles.body(
                  color: AppColors.textMuted,
                ),

                border: InputBorder.none,

                contentPadding:
                const EdgeInsets.all(
                  AppSpacing.md,
                ),

                counterText: "",
              ),
            ),
          ),
        ),

        if (widget.helperText != null &&
            !hasError)

          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
            ),
            child: Text(
              widget.helperText!,
              style: AppTextStyles.caption(),
            ),
          ),

        if (hasError)

          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
            ),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.caption(
                color:
                AppColors.inputErrorBorder,
              ),
            ),
          ),
      ],
    );
  }
}