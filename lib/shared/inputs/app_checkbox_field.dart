import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class AppCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool)? onChanged;
  final String? label;
  final bool enabled;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.enabled = true,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  void _toggle() {
    if (!widget.enabled) return;
    widget.onChanged?.call(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final isChecked = widget.value;
    final isDisabled = !widget.enabled;

    return GestureDetector(
      onTap: _toggle,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,

              width: 22,
              height: 22,

              decoration: BoxDecoration(
                color: isChecked
                    ? AppColors.primaryGreen
                    : AppColors.secondaryGreen,

                borderRadius: BorderRadius.circular(6),

                border: Border.all(
                  color: isChecked
                      ? AppColors.primaryGreen
                      : AppColors.border,
                  width: 1.5,
                ),

                boxShadow: isChecked
                    ? [
                  BoxShadow(
                    color: AppColors.accentGreen.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
                    : [],
              ),

              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: isChecked
                    ? const Icon(
                  Icons.check,
                  key: ValueKey("check"),
                  size: 16,
                  color: Colors.white,
                )
                    : const SizedBox(),
              ),
            ),

            if (widget.label != null) ...[
              const SizedBox(width: 10),
              Text(
                widget.label!,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}