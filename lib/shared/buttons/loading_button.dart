import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_duration.dart';
import '../../core/constants/app_elevation.dart';
import '../../core/constants/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final double height;
  final double width;

  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 54,
    this.width = double.infinity,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _loading = false;
  bool _pressed = false;

  Future<void> _handleTap() async {
    if (_loading || widget.onPressed == null) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null || _loading;

    return GestureDetector(
      onTapDown: disabled
          ? null
          : (_) {
        setState(() => _pressed = true);
      },
      onTapUp: disabled
          ? null
          : (_) {
        setState(() => _pressed = false);
        _handleTap();
      },
      onTapCancel: () {
        if (mounted) {
          setState(() => _pressed = false);
        }
      },
      child: AnimatedContainer(
        duration: AppDuration.fast,
        curve: Curves.easeOut,
        height: widget.height,
        width: widget.width,
        transform: Matrix4.identity()
          ..translate(0.0, _pressed ? 2.0 : 0.0)
          ..scale(_pressed ? 0.985 : 1.0),
        decoration: BoxDecoration(
          borderRadius: AppRadius.button,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: disabled
                ? [
              AppColors.disabledBackground,
              AppColors.disabledBackground,
            ]
                : [
              AppColors.primary,
              AppColors.primary,
            ],
          ),
          boxShadow: disabled ? [] : AppElevation.button,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: AppDuration.normal,
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _loading
                ? SizedBox(
              key: const ValueKey("loader"),
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor: AlwaysStoppedAnimation(
                  AppColors.white,
                ),
              ),
            )
                : Text(
              widget.text,
              key: const ValueKey("text"),
              style: AppTextStyles.button(),
            ),
          ),
        ),
      ),
    );
  }
}