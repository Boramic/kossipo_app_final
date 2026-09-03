import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium(
            color: AppColors.textPrimary,
          ),
        ),

        if (actionText != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText!,
              style: AppTextStyles.bodySmall(
                color: AppColors.primaryGreen,
                weight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}