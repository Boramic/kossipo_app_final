import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class FamilyMemberNode extends StatelessWidget {
  final String id;
  final String image;
  final String fullName;
  final String relationship;
  final bool isSelected;
  final bool isExpanded;
  final bool isInactive;
  final bool isDeceased;
  final bool hasChildren;
  final VoidCallback onTap;
  final VoidCallback? onExpand;

  const FamilyMemberNode({
    super.key,
    required this.id,
    required this.image,
    required this.fullName,
    required this.relationship,
    required this.isSelected,
    required this.isExpanded,
    required this.isInactive,
    required this.isDeceased,
    required this.hasChildren,
    required this.onTap,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = isInactive ? 0.35 : 1.0;
    final scale = isSelected ? 1.08 : 1.0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 280),
      opacity: opacity,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 280),
        scale: scale,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  /// OUTER GLOW
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSelected ? 96 : 86,
                    height: isSelected ? 96 : 86,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: isDeceased
                            ? [
                          AppColors.textMuted.withValues(alpha: .4),
                          AppColors.textMuted.withValues(alpha: .2),
                        ]
                            : [
                          AppColors.primary.withValues(alpha: .7),
                          AppColors.primaryGreen.withValues(alpha: .8),
                        ],
                      ),
                    ),
                  ),

                  /// INNER WHITE CONTAINER
                  Container(
                    width: 82,
                    height: 82,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Hero(
                      tag: id,
                      child: ClipOval(
                        child: image.isNotEmpty
                            ? Image.asset(
                          image,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          color: AppColors.background,
                          child: const Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// STATUS DOT
                  Positioned(
                    right: 4,
                    top: 6,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isDeceased
                            ? AppColors.textMuted
                            : AppColors.primaryGreen,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  /// EXPAND BUTTON
                  if (hasChildren)
                    Positioned(
                      bottom: -10,
                      child: GestureDetector(
                        onTap: onExpand,
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 280),
                          turns: isExpanded ? 0.5 : 0,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  color: Colors.black.withValues(alpha: .08),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 18),

              /// NAME
              SizedBox(
                width: 110,
                child: Text(
                  fullName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              /// RELATIONSHIP BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .08),
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  relationship,
                  style: AppTextStyles.caption(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}