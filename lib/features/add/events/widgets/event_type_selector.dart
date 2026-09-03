import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../models/family_event.dart';

class EventTypeSelector extends StatelessWidget {
  const EventTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final FamilyEventType selectedType;
  final ValueChanged<FamilyEventType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Event Type',
          style: AppTextStyles.bodyMedium(
            weight: FontWeight.w700,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: FamilyEventType.values
              .map(
                (type) => _TypeChip(
              type: type,
              selected:
              type == selectedType,
              onTap: () =>
                  onChanged(type),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final FamilyEventType type;
  final bool selected;
  final VoidCallback onTap;

  String get label {
    switch (type) {
      case FamilyEventType.reunion:
        return 'Reunion';

      case FamilyEventType.wedding:
        return 'Wedding';

      case FamilyEventType.birthday:
        return 'Birthday';

      case FamilyEventType.funeral:
        return 'Funeral';

      case FamilyEventType.meeting:
        return 'Meeting';

      case FamilyEventType.ceremony:
        return 'Ceremony';

      case FamilyEventType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (type) {
      case FamilyEventType.reunion:
        return Icons.groups_rounded;

      case FamilyEventType.wedding:
        return Icons.favorite_rounded;

      case FamilyEventType.birthday:
        return Icons.cake_rounded;

      case FamilyEventType.funeral:
        return Icons.local_florist_rounded;

      case FamilyEventType.meeting:
        return Icons.handshake_rounded;

      case FamilyEventType.ceremony:
        return Icons.celebration_rounded;

      case FamilyEventType.other:
        return Icons.event_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
      BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryGreen
              : AppColors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.primaryGreen
                : AppColors.border,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              blurRadius: 14,
              color: AppColors
                  .primaryGreen
                  .withValues(
                alpha: .18,
              ),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? Colors.white
                  : AppColors.primaryGreen,
            ),

            const SizedBox(width: 8),

            Text(
              label,
              style: AppTextStyles.bodySmall(
                weight: FontWeight.w600,
                color: selected
                    ? Colors.white
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}