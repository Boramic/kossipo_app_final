import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class CreationCenterCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const CreationCenterCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  State<CreationCenterCard> createState() =>
      _CreationCenterCardState();
}

class _CreationCenterCardState
    extends State<CreationCenterCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        scale: _pressed ? .97 : 1,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,

          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),

          decoration: BoxDecoration(
            borderRadius: AppRadius.card,

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                AppColors.primaryGreen.withValues(
                  alpha: .025,
                ),
              ],
            ),

            border: Border.all(
              color: _pressed
                  ? AppColors.primaryGreen
                  .withValues(alpha: .25)
                  : AppColors.primaryGreen
                  .withValues(alpha: .08),
            ),

            boxShadow: [
              ...AppShadows.cardSoft,

              BoxShadow(
                blurRadius: _pressed ? 12 : 24,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  _pressed ? 2 : 8,
                ),
                color: AppColors.primaryGreen
                    .withValues(alpha: .08),
              ),
            ],
          ),

          child: Column(
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

                  color: AppColors.primaryGreen
                      .withValues(alpha: .10),
                ),

                child: Icon(
                  widget.icon,
                  size: 28,
                  color: AppColors.primaryGreen,
                ),
              ),

              const Spacer(),

              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body(
                  weight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Text(
                    "Open",
                    style: AppTextStyles.caption(
                      color: AppColors.primaryGreen,
                    ),
                  ),

                  const Spacer(),

                  AnimatedSlide(
                    duration:
                    const Duration(milliseconds: 180),
                    offset: _pressed
                        ? const Offset(.18, 0)
                        : Offset.zero,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color:
                      AppColors.primaryGreen,
                    ),
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