import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class GhostButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const GhostButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 54,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bool disabled =
        widget.isDisabled ||
            widget.isLoading ||
            widget.onPressed == null;

    return GestureDetector(
      onTapDown: disabled
          ? null
          : (_) => setState(() => _pressed = true),

      onTapUp: disabled
          ? null
          : (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      },

      onTapCancel: disabled
          ? null
          : () => setState(() => _pressed = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: widget.width ?? double.infinity,
        height: widget.height,
        transform: Matrix4.identity()
          ..translate(0.0, _pressed ? 2.0 : 0.0)
          ..scale(_pressed ? 0.985 : 1.0),
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.disabledBackground
              : AppColors.secondaryGreen,
          borderRadius: AppRadius.button,
          border: Border.all(
            color: disabled
                ? AppColors.disabled
                : AppColors.primaryGreen,
            width: 1.5,
          ),
          boxShadow: disabled
              ? []
              : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: _pressed ? 4 : 10,
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
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.prefixIcon != null) ...[
                widget.prefixIcon!,
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: AppTextStyles.button(
                  color: disabled
                      ? AppColors.textMuted
                      : AppColors.primaryGreen,
                ),
              ),
              if (widget.suffixIcon != null) ...[
                const SizedBox(width: 8),
                widget.suffixIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}