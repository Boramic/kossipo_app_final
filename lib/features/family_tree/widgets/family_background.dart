import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class FamilyBackground extends StatefulWidget {
  const FamilyBackground({
    super.key,
  });

  @override
  State<FamilyBackground> createState() =>
      _FamilyBackgroundState();
}

class _FamilyBackgroundState
    extends State<FamilyBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 8,
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _FamilyBackgroundPainter(
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class _FamilyBackgroundPainter extends CustomPainter {
  final double progress;

  _FamilyBackgroundPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintBaseGradient(canvas, size);
    _paintGlow(canvas, size);
    _paintRoots(canvas, size);
    _paintParticles(canvas, size);
  }

  void _paintBaseGradient(
      Canvas canvas,
      Size size,
      ) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.background,
          AppColors.secondaryGreen.withValues(
            alpha: 0.18,
          ),
          AppColors.background,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  void _paintGlow(
      Canvas canvas,
      Size size,
      ) {
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryGreen.withValues(
            alpha: 0.14 + (progress * 0.08),
          ),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * 0.5,
            size.height * 0.35,
          ),
          radius: 220,
        ),
      );

    canvas.drawCircle(
      Offset(
        size.width * 0.5,
        size.height * 0.35,
      ),
      220,
      glowPaint,
    );
  }

  void _paintRoots(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color = AppColors.primaryGreen.withValues(
        alpha: 0.08,
      )
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    final path = Path();

    final rootX = size.width / 2;
    final rootY = size.height * 0.12;

    path.moveTo(rootX, rootY);

    for (int i = 1; i < 10; i++) {
      final dx = sin(i + progress * pi) * 70;
      final dy = i * 120.0;

      path.quadraticBezierTo(
        rootX + dx,
        rootY + dy - 50,
        rootX + dx * 1.4,
        rootY + dy,
      );
    }

    canvas.drawPath(path, paint);

    final mirrorPath = Path();

    mirrorPath.moveTo(rootX, rootY);

    for (int i = 1; i < 10; i++) {
      final dx = -sin(i + progress * pi) * 70;
      final dy = i * 120.0;

      mirrorPath.quadraticBezierTo(
        rootX + dx,
        rootY + dy - 50,
        rootX + dx * 1.4,
        rootY + dy,
      );
    }

    canvas.drawPath(
      mirrorPath,
      paint,
    );
  }

  void _paintParticles(
      Canvas canvas,
      Size size,
      ) {
    final random = Random(42);

    for (int i = 0; i < 18; i++) {
      final dx =
          random.nextDouble() * size.width;

      final dy =
          random.nextDouble() * size.height;

      final radius =
          2 + (progress * 3);

      final paint = Paint()
        ..color =
        AppColors.primaryGreen.withValues(
          alpha: 0.08,
        );

      canvas.drawCircle(
        Offset(dx, dy),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant _FamilyBackgroundPainter oldDelegate,
      ) {
    return oldDelegate.progress != progress;
  }
}