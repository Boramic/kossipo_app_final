import 'package:flutter/material.dart';

import '../../core/constants/app_borders.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_elevation.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AppDateField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChanged;
  final String? helperText;
  final String? errorText;
  final bool enabled;

  const AppDateField({
    super.key,
    this.label,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.helperText,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  bool focused = false;
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  String _format(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  Future<void> _pickDate() async {
    if (!widget.enabled) return;

    setState(() => focused = true);

    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      helpText: "Select date",
      cancelText: "Cancel",
      confirmText: "Confirm",
    );

    setState(() => focused = false);

    if (picked != null) {
      setState(() => selectedDate = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final isDisabled = !widget.enabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.label()),
          const SizedBox(height: AppSpacing.xs),
        ],

        GestureDetector(
          onTapDown: (_) => setState(() => pressed = true),
          onTapUp: (_) => setState(() => pressed = false),
          onTapCancel: () => setState(() => pressed = false),
          onTap: _pickDate,

          child: AnimatedScale(
            duration: const Duration(milliseconds: 120),
            scale: pressed ? 0.98 : 1.0,

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),

              decoration: BoxDecoration(
                color: isDisabled
                    ? AppColors.disabledBackground
                    : AppColors.secondaryGreen,

                borderRadius: AppRadius.input,

                border: Border.all(
                  color: hasError
                      ? AppColors.error
                      : focused
                      ? AppColors.primaryGreen
                      : AppColors.border,
                  width: focused ? AppBorders.focus : AppBorders.input,
                ),

                boxShadow: isDisabled
                    ? AppElevation.none
                    : focused
                    ? [
                  BoxShadow(
                    color: AppColors.primaryGreen
                        .withValues(alpha: 0.15),
                    blurRadius: 14,
                    spreadRadius: -2,
                  ),
                ]
                    : AppElevation.level1,
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primaryGreen,
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? (widget.hintText ?? "Select date")
                          : _format(selectedDate!),
                      style: AppTextStyles.body(
                        color: selectedDate == null
                            ? AppColors.textMuted
                            : AppColors.primaryGreen,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryGreen,
                  ),
                ],
              ),
            ),
          ),
        ),

        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.caption(color: AppColors.error),
            ),
          ),

        if (widget.errorText == null && widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              widget.helperText!,
              style: AppTextStyles.caption(),
            ),
          ),
      ],
    );
  }
}