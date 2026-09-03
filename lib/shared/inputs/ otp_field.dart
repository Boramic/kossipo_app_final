import 'package:flutter/material.dart';

import '../../core/constants/app_borders.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_elevation.dart';
import '../../core/constants/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class AppOtpField extends StatefulWidget {
  final int length;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  final bool enabled;
  final bool autoFocus;

  final String? helperText;
  final String? errorText;

  const AppOtpField({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.enabled = true,
    this.autoFocus = true,
    this.helperText,
    this.errorText,
  });

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      widget.length,
          (_) => TextEditingController(),
    );

    focusNodes = List.generate(
      widget.length,
          (_) => FocusNode(),
    );

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          focusNodes.first.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }

    for (final f in focusNodes) {
      f.dispose();
    }

    super.dispose();
  }

  String get currentCode =>
      controllers.map((e) => e.text).join();

  void _notify() {
    widget.onChanged?.call(currentCode);

    if (!currentCode.contains("") &&
        currentCode.length == widget.length) {
      widget.onCompleted?.call(currentCode);
    }
  }

  void _handlePaste(String value) {
    if (value.length <= 1) return;

    final chars = value.split("");

    for (int i = 0; i < widget.length; i++) {
      controllers[i].text =
      i < chars.length ? chars[i] : "";
    }

    FocusScope.of(context).unfocus();

    _notify();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {

            return SizedBox(
              width: 48,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                decoration: BoxDecoration(
                  color: hasError
                      ? AppColors.inputError
                      : AppColors.secondaryGreen,

                  borderRadius: AppRadius.input,

                  border: Border.all(
                    color: hasError
                        ? AppColors.inputErrorBorder
                        : focusNodes[index].hasFocus
                        ? AppColors.inputFocus
                        : AppColors.border,
                    width: AppBorders.normal,
                  ),

                  boxShadow: focusNodes[index].hasFocus
                      ? AppElevation.greenGlow
                      : AppElevation.level1,
                ),

                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],

                  enabled: widget.enabled,

                  keyboardType: TextInputType.number,

                  textAlign: TextAlign.center,

                  maxLength: 1,

                  style: AppTextStyles.titleMedium(),

                  decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),

                  onChanged: (value) {

                    if (value.length > 1) {
                      _handlePaste(value);
                      return;
                    }

                    if (value.isNotEmpty &&
                        index < widget.length - 1) {
                      focusNodes[index + 1].requestFocus();
                    }

                    if (value.isEmpty &&
                        index > 0) {
                      focusNodes[index - 1].requestFocus();
                    }

                    _notify();

                    setState(() {});
                  },
                ),
              ),
            );
          }),
        ),

        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.helperText!,
              style: AppTextStyles.bodySmall(
                color: AppColors.textMuted,
              ),
            ),
          ),

        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.bodySmall(
                color: AppColors.inputErrorBorder,
              ),
            ),
          ),
      ],
    );
  }
}