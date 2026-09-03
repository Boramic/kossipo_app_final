import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    final shortcuts = [
      {
        "title": "Members",
        "icon": Icons.people_alt_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Memories",
        "icon": Icons.photo_library_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Events",
        "icon": Icons.event_rounded,
        "color": Colors.purple,
      },
      {
        "title": "Stories",
        "icon": Icons.menu_book_rounded,
        "color": Colors.green,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shortcuts.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,

        // légèrement plus haut pour éviter les overflow
        childAspectRatio: 1.08,
      ),
      itemBuilder: (context, index) {
        final item = shortcuts[index];

        return _ShortcutCard(
          title: item["title"] as String,
          icon: item["icon"] as IconData,
          color: item["color"] as Color,
          onTap: () {},
        );
      },
    );
  }
}

class _ShortcutCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ShortcutCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ShortcutCard> createState() => _ShortcutCardState();
}

class _ShortcutCardState extends State<_ShortcutCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: isPressed ? 0.96 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.white,
                widget.color.withValues(alpha: 0.06),
              ],
            ),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.10),
            ),
            boxShadow: [
              ...AppShadows.cardSoft,
              BoxShadow(
                color: widget.color.withValues(alpha: 0.12),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.color,
                ),
              ),

              const Expanded(
                child: SizedBox(),
              ),

              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall(
                  weight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  Text(
                    "Open",
                    style: AppTextStyles.caption(
                      color: AppColors.textMuted,
                    ),
                  ),

                  const Spacer(),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: widget.color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}