import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

class SheetHandle extends StatelessWidget {
  const SheetHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.sm,
        bottom: AppSpacing.lg,
      ),
      child: Container(
        width: 48,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(
            999,
          ),
        ),
      ),
    );
  }
}