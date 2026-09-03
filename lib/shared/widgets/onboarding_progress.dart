import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OnboardingProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalSteps,
            (index) {
          final isActive = index == currentStep;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: isActive ? 28 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}