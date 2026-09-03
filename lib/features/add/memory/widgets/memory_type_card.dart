import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_shadows.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class MemoryTypeCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const MemoryTypeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<MemoryTypeCard> createState() =>
      _MemoryTypeCardState();
}

class _MemoryTypeCardState
    extends State<MemoryTypeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: widget.onTap,

      onTapDown: (_) {
        setState(() => _pressed = true);
      },

      onTapUp: (_) {
        setState(() => _pressed = false);
      },

      onTapCancel: () {
        setState(() => _pressed = false);
      },

      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        scale: _pressed ? .98 : 1,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,

          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: AppRadius.card,

            border: Border.all(
              color: _pressed
                  ? AppColors.primaryGreen.withValues(alpha: .25)
                  : AppColors.border.withValues(alpha: .35),
            ),

            boxShadow: [
              ...AppShadows.cardSoft,

              BoxShadow(
                blurRadius: _pressed ? 10 : 22,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  _pressed ? 3 : 8,
                ),
                color: AppColors.primaryGreen
                    .withValues(alpha: .08),
              ),
            ],
          ),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),

                width: 56,
                height: 56,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryGreen
                          .withValues(alpha: .14),

                      AppColors.primaryGreen
                          .withValues(alpha: .05),
                    ],
                  ),
                ),

                child: Icon(
                  widget.icon,
                  color: AppColors.primaryGreen,
                  size: 28,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      widget.title,
                      style:
                      AppTextStyles.body(
                        weight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      widget.description,
                      style:
                      AppTextStyles.caption(
                        color:
                        AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              AnimatedSlide(
                duration:
                const Duration(milliseconds: 180),

                offset: _pressed
                    ? const Offset(.15, 0)
                    : Offset.zero,

                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color:
                  AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}