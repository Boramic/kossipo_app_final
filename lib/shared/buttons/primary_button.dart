import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: isDisabled
          ? null
          : (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: isDisabled ? null : () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 54,

        // 🔥 3D EFFECT (PRESS ANIMATION)
        transform: Matrix4.identity()
          ..translate(0.0, _pressed ? 2.5 : 0.0, 0.0)
          ..scale(_pressed ? 0.98 : 1.0),

        decoration: BoxDecoration(
          borderRadius: AppRadius.button,

          // 🌿 GRADIENT (MODERN NATURAL LOOK)
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDisabled
                ? [
              AppColors.disabled,
              AppColors.disabled,
            ]
                : [
              AppColors.primary,
              AppColors.accentGreen,
            ],
          ),

          // 🌑 SOFT SHADOW (3D FLOATING EFFECT)
          boxShadow: isDisabled
              ? []
              : [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: _pressed ? 6 : 14,
              offset: Offset(0, _pressed ? 2 : 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Center(
          child: widget.isLoading
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Text(
            widget.text,
            style: AppTextStyles.button().copyWith(
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}