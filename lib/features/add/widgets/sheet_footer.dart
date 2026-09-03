import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';

class SheetFooter extends StatelessWidget {
  final String quote;

  final String primaryButtonText;
  final String? secondaryButtonText;

  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  final bool loading;

  const SheetFooter({
    super.key,
    required this.quote,
    required this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: AppSpacing.xl,
      ),
      padding: const EdgeInsets.only(
        top: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border.withValues(
              alpha: .35,
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "✦ $quote",
            textAlign: TextAlign.center,
            style: AppTextStyles.caption(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          PrimaryButton(
            text: primaryButtonText,
            isLoading: loading,
            onPressed: onPrimaryPressed,
          ),

          if (secondaryButtonText != null) ...[
            const SizedBox(
              height: AppSpacing.sm,
            ),

            GhostButton(
              text: secondaryButtonText!,
              onPressed: onSecondaryPressed,
            ),
          ],

          const SizedBox(
            height: AppSpacing.lg,
          ),
        ],
      ),
    );
  }
}