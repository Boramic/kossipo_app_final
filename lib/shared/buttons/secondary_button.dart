import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled =
        widget.isDisabled || widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown:
      isDisabled ? null : (_) => setState(() => _pressed = true),

      onTapUp: isDisabled
          ? null
          : (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      },

      onTapCancel:
      isDisabled ? null : () => setState(() => _pressed = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,

        width: double.infinity,
        height: 54,

        transform: Matrix4.identity()
          ..translate(0.0, _pressed ? 2.0 : 0.0)
          ..scale(_pressed ? 0.98 : 1.0),

        decoration: BoxDecoration(
          borderRadius: AppRadius.button,

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDisabled
                ? [
              AppColors.disabledBackground,
              AppColors.disabledBackground,
            ]
                : [
              AppColors.secondaryGreen,
              AppColors.surface,
            ],
          ),

          border: Border.all(
            color: isDisabled
                ? AppColors.disabled
                : AppColors.primaryGreen,
            width: 1.5,
          ),

          boxShadow: isDisabled
              ? []
              : [
            BoxShadow(
              color: AppColors.primaryOpacity(0.12),
              blurRadius: _pressed ? 6 : 12,
              offset: Offset(0, _pressed ? 2 : 5),
            ),
          ],
        ),

        child: Center(
          child: widget.isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryGreen,
            ),
          )
              : Text(
            widget.text,
            style: AppTextStyles.button(
              color: isDisabled
                  ? AppColors.textMuted
                  : AppColors.primaryGreen,
            ),
          ),
        ),
      ),
    );
  }
}