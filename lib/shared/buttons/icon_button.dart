import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_elevation.dart';

class AppIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final bool isLoading;
  final bool isDisabled;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _pressed = false;

  bool get isActive =>
      widget.onPressed != null && !widget.isDisabled && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: isActive ? (_) => setState(() => _pressed = true) : null,
      onTapUp: isActive
          ? (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      }
          : null,
      onTapCancel: isActive ? () => setState(() => _pressed = false) : null,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,

        width: widget.size,
        height: widget.size,

        transform: Matrix4.identity()
          ..translate(0.0, _pressed ? 2 : 0.0)
          ..scale(_pressed ? 0.96 : 1.0),

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDisabled
                ? [
              AppColors.disabledBackground,
              AppColors.disabledBackground,
            ]
                : [
              AppColors.secondaryGreen.withOpacity(0.4),
              Colors.white,
            ],
          ),

          border: Border.all(
            color: widget.isDisabled
                ? AppColors.disabled
                : AppColors.primaryGreen.withOpacity(0.6),
            width: 1.2,
          ),

          boxShadow: widget.isDisabled
              ? AppElevation.none
              : (_pressed
              ? AppElevation.pressed
              : AppElevation.level2),
        ),

        child: Center(
          child: widget.isLoading
              ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryGreen,
            ),
          )
              : Icon(
            widget.icon,
            size: 22,
            color: widget.isDisabled
                ? AppColors.disabled
                : AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }
}








































