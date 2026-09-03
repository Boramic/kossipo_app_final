import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';

class SheetHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SheetHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.xl,
      ),
      child: Column(
        children: [
          Container(
            width: AppSizes.avatarMd,
            height: AppSizes.avatarMd,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen
                  .withValues(alpha: .08),

              borderRadius: AppRadius.circle,

              border: Border.all(
                color: AppColors.primaryGreen
                    .withValues(alpha: .12),
              ),
            ),
            child: Icon(
              icon,
              size: AppSizes.iconLg,
              color: AppColors.primaryGreen,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge(),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}