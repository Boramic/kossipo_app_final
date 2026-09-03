import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class FamilyTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> timeline;

  const FamilyTimeline({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.cardSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Family Timeline",
            style: AppTextStyles.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timeline.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = timeline[index];
              final bool isLast =
                  index == timeline.length - 1;

              return _TimelineItem(
                year: item['year'],
                title: item['title'],
                description: item['description'],
                type: item['type'],
                isLast: isLast,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final String type;
  final bool isLast;

  const _TimelineItem({
    required this.year,
    required this.title,
    required this.description,
    required this.type,
    required this.isLast,
  });

  Color get _typeColor {
    switch (type) {
      case 'birth':
        return AppColors.success;

      case 'marriage':
        return AppColors.primaryGreen;

      case 'migration':
        return AppColors.info;

      case 'death':
        return AppColors.error;

      case 'tradition':
        return AppColors.warning;

      default:
        return AppColors.notificationNormal;
    }
  }

  IconData get _typeIcon {
    switch (type) {
      case 'birth':
        return Icons.child_care;

      case 'marriage':
        return Icons.favorite;

      case 'migration':
        return Icons.flight_takeoff;

      case 'death':
        return Icons.auto_awesome_mosaic;

      case 'tradition':
        return Icons.celebration;

      default:
        return Icons.history;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _typeColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _typeIcon,
                  color: _typeColor,
                  size: 20,
                ),
              ),

              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xs,
                    ),
                    color: AppColors.divider,
                  ),
                ),
            ],
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: AppRadius.card,
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: AppTextStyles.caption(
                      color: AppColors.textMuted,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  Text(
                    title,
                    style: AppTextStyles.bodySmall(
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  Text(
                    description,
                    style: AppTextStyles.caption(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}