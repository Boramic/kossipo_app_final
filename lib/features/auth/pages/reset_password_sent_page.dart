import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';

class ResetPasswordSentPage extends StatelessWidget {
  const ResetPasswordSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 52,
                  color: AppColors.primaryGreen,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Check your email",
                style: AppTextStyles.h2(),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              Text(
                "We sent you a password reset link. Open your email and follow the instructions to reset your password.",
                style: AppTextStyles.bodySmall(),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: "Back to Sign In",
                onPressed: () {
                  AppRouter.clearAndPush(
                    context,
                    AppRoutes.login,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}