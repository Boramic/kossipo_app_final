import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class PromoCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> promos;
  final Duration autoSlideDuration;

  const PromoCarousel({
    super.key,
    required this.promos,
    this.autoSlideDuration = const Duration(seconds: 5),
  });

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late final PageController _controller;
  Timer? _autoSlideTimer;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      viewportFraction: 0.92,
    );

    _startAutoSlide();
  }

  void _startAutoSlide() {
    if (widget.promos.isEmpty) return;

    _autoSlideTimer?.cancel();

    _autoSlideTimer = Timer.periodic(
      widget.autoSlideDuration,
          (_) {
        if (!mounted) return;
        if (!_controller.hasClients) return;

        final nextIndex =
            (_currentIndex + 1) % widget.promos.length;

        _controller.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      },
    );
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.promos.length,
            onPageChanged: (index) {
              if (!mounted) return;

              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final promo = widget.promos[index];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                margin: EdgeInsets.only(
                  right: index == widget.promos.length - 1
                      ? 0
                      : AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.card,
                  boxShadow: AppShadows.cardSoft,
                ),
                child: ClipRRect(
                  borderRadius: AppRadius.card,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        promo["image"],
                        fit: BoxFit.cover,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              AppColors.blackOpacity(0.72),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        left: AppSpacing.md,
                        right: AppSpacing.md,
                        bottom: AppSpacing.md,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo["title"] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body(
                                color: AppColors.white,
                                weight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(
                              height: AppSpacing.xs,
                            ),

                            Text(
                              promo["subtitle"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.promos.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primaryGreen
                    : AppColors.border,
                borderRadius: AppRadius.pill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}