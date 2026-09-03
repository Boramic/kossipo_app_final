import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../data/services/auth_service.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: AuthService.getCurrentUserData(),
        builder: (context, snapshot) {
          final userData = snapshot.data;

          final String familyName =
              userData?['familyName'] ?? 'Waffo Foka';

          final String familyCode =
              userData?['familyCode'] ?? 'WF';

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.white,
                  AppColors.secondaryGreen.withValues(alpha: 0.25),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.06),
                ),
              ),
              boxShadow: AppShadows.header,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.md,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.12),
                        AppColors.primaryGreen.withValues(alpha: 0.18),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Center(
                    child: snapshot.connectionState ==
                        ConnectionState.waiting
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      familyCode,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.primaryGreen,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Family Space',
                        style: AppTextStyles.caption(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        familyName,
                        style: AppTextStyles.titleMedium(
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.maybeOf(context)?.openDrawer();
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppRadius.md,
                          boxShadow: AppShadows.cardSoft,
                        ),
                        child: const Icon(
                          Icons.menu_rounded,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}