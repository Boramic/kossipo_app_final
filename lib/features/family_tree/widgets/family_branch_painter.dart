import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class FamilyBranchPainter extends CustomPainter {
  final int childrenCount;
  final double progress;
  final bool isFocused;

  FamilyBranchPainter({
    required this.childrenCount,
    required this.progress,
    required this.isFocused,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (childrenCount <= 0) return;

    final centerX = size.width / 2;
    const rootStartY = 0.0;
    final rootEndY = size.height * 0.28;

    /// ROOT LINE STYLE
    final rootPaint = Paint()
      ..color = isFocused
          ? AppColors.primaryGreen
          : AppColors.primary.withValues(alpha: 0.55)
      ..strokeWidth = isFocused ? 3.2 : 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    /// SOFT GLOW
    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        10,
      )
      ..style = PaintingStyle.stroke;

    /// MAIN ROOT
    final rootPath = Path()
      ..moveTo(centerX, rootStartY)
      ..lineTo(centerX, rootEndY * progress);

    canvas.drawPath(rootPath, glowPaint);
    canvas.drawPath(rootPath, rootPaint);

    /// CHILD BRANCHES
    final spacing = size.width / (childrenCount + 1);

    for (int i = 0; i < childrenCount; i++) {
      final childX = spacing * (i + 1);
      final childY = size.height;

      final path = Path()
        ..moveTo(centerX, rootEndY)
        ..cubicTo(
          centerX,
          rootEndY + 30,
          childX,
          rootEndY + 45,
          childX,
          childY * progress,
        );

      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, rootPaint);
    }
  }

  @override
  bool shouldRepaint(covariant FamilyBranchPainter oldDelegate) {
    return oldDelegate.childrenCount != childrenCount ||
        oldDelegate.progress != progress ||
        oldDelegate.isFocused != isFocused;
  }
}