import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "title": "Add Memory",
        "icon": Icons.photo_library_outlined,
      },
      {
        "title": "Add Story",
        "icon": Icons.auto_stories_outlined,
      },
      {
        "title": "Add Event",
        "icon": Icons.event_outlined,
      },
      {
        "title": "Invite",
        "icon": Icons.group_add_outlined,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];

        return _QuickActionCard(
          title: action["title"] as String,
          icon: action["icon"] as IconData,
        );
      },
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final String title;
  final IconData icon;

  const _QuickActionCard({
    required this.title,
    required this.icon,
  });

  @override
  State<_QuickActionCard> createState() =>
      _QuickActionCardState();
}

class _QuickActionCardState
    extends State<_QuickActionCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      onTap: () {},
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        scale: isPressed ? 0.96 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.card,
            boxShadow: AppShadows.cardSoft,
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primaryGreen,
                  size: 20,
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyles.bodySmall(
                    color: AppColors.textPrimary,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}