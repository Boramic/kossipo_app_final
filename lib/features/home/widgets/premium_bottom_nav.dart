import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.add_rounded,
    Icons.notifications_active_rounded,
  ];

  static const List<String> _labels = [
    "Home",
    "Create",
    "Notifications",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.primaryGreen.withValues(
              alpha: .08,
            ),
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 28,
            offset: const Offset(0, -6),
            color: AppColors.primaryGreen.withValues(
              alpha: .08,
            ),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(
            _icons.length,
                (index) {
              return Expanded(
                child: _NavItem(
                  icon: _icons[index],
                  label: _labels[index],
                  active: currentIndex == index,
                  isCenter: index == 1,
                  onTap: () => onTap(index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool isCenter;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = active
        ? AppColors.primaryGreen
        : AppColors.textMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeOutCubic,
                width: isCenter
                    ? (active ? 58 : 52)
                    : (active ? 50 : 44),
                height: isCenter
                    ? (active ? 58 : 52)
                    : (active ? 50 : 44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    isCenter ? 18 : 16,
                  ),
                  color: active
                      ? AppColors.primaryGreen
                      .withValues(alpha: .12)
                      : Colors.transparent,
                  border: active
                      ? Border.all(
                    color: AppColors.primaryGreen
                        .withValues(alpha: .15),
                  )
                      : null,
                  boxShadow: active
                      ? [
                    BoxShadow(
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                      color: AppColors.primaryGreen
                          .withValues(alpha: .14),
                    ),
                  ]
                      : [],
                ),
                child: Center(
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 220,
                    ),
                    curve: Curves.easeOut,
                    scale: active ? 1.08 : 1,
                    child: Icon(
                      icon,
                      size: isCenter ? 30 : 24,
                      color: iconColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              AnimatedDefaultTextStyle(
                duration: const Duration(
                  milliseconds: 220,
                ),
                style: TextStyle(
                  fontSize: active ? 12 : 11,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w600,
                  color: active
                      ? AppColors.primaryGreen
                      : AppColors.textMuted,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}