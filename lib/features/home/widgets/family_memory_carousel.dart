import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class FamilyMemoryCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> memories;
  final bool autoPlay;
  final Duration autoPlayDuration;

  const FamilyMemoryCarousel({
    super.key,
    required this.memories,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(seconds: 6),
  });

  @override
  State<FamilyMemoryCarousel> createState() =>
      _FamilyMemoryCarouselState();
}

class _FamilyMemoryCarouselState
    extends State<FamilyMemoryCarousel> {
  late final PageController _controller;
  Timer? _autoPlayTimer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      viewportFraction: 0.88,
    );

    _startAutoPlay();
  }

  void _startAutoPlay() {
    if (!widget.autoPlay || widget.memories.isEmpty) return;

    _autoPlayTimer?.cancel();

    _autoPlayTimer = Timer.periodic(
      widget.autoPlayDuration,
          (_) {
        if (!mounted || !_controller.hasClients) return;

        final nextPage =
            (_currentPage + 1) % widget.memories.length;

        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOutCubic,
        );
      },
    );
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.memories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.memories.length,
            onPageChanged: (index) {
              if (!mounted) return;

              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              final memory = widget.memories[index];
              final isActive = _currentPage == index;

              return AnimatedScale(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                scale: isActive ? 1 : 0.94,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isActive ? 1 : 0.85,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.card,
                      boxShadow: AppShadows.cardSoft,
                    ),
                    child: ClipRRect(
                      borderRadius: AppRadius.card,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              memory['image'],
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned.fill(
                            child: Container(
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
                          ),

                          Positioned(
                            top: 14,
                            left: 14,
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteOpacity(
                                  0.18,
                                ),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                memory['date'],
                                style: AppTextStyles.caption(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 18,
                            left: 18,
                            right: 18,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  memory['title'],
                                  style:
                                  AppTextStyles.titleMedium(
                                    color: AppColors.white,
                                  ),
                                ),

                                const SizedBox(
                                  height: AppSpacing.xs,
                                ),

                                Text(
                                  memory['author'],
                                  style:
                                  AppTextStyles.caption(
                                    color:
                                    AppColors.whiteOpacity(
                                      0.85,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: AppSpacing.md,
                                ),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.photo_library_rounded,
                                      color: AppColors.white,
                                      size: 18,
                                    ),

                                    const SizedBox(
                                      width: AppSpacing.xs,
                                    ),

                                    Text(
                                      '${memory['count']} photos',
                                      style:
                                      AppTextStyles.bodySmall(
                                        color: AppColors.white,
                                      ),
                                    ),

                                    const Spacer(),

                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal:
                                        AppSpacing.md,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                        AppColors.primaryGreen,
                                        borderRadius:
                                        AppRadius.pill,
                                      ),
                                      child: Text(
                                        'View',
                                        style:
                                        AppTextStyles.bodySmall(
                                          color:
                                          AppColors.white,
                                          weight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
            widget.memories.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              width: _currentPage == index ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: AppRadius.pill,
                color: _currentPage == index
                    ? AppColors.primaryGreen
                    : AppColors.disabled,
              ),
            ),
          ),
        ),
      ],
    );
  }
}