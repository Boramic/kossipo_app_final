import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/event_model.dart';

class CulturalEventGrid extends StatefulWidget {
  final List<CulturalEvent> events;
  final VoidCallback? onExplore;
  final bool autoRotate;
  final Duration autoRotateDuration;

  const CulturalEventGrid({
    super.key,
    required this.events,
    this.onExplore,
    this.autoRotate = true,
    this.autoRotateDuration = const Duration(seconds: 7),
  });

  @override
  State<CulturalEventGrid> createState() =>
      _CulturalEventGridState();
}

class _CulturalEventGridState
    extends State<CulturalEventGrid> {
  Timer? _rotationTimer;
  int _startIndex = 0;

  List<CulturalEvent> get _visibleEvents {
    if (widget.events.length <= 4) {
      return widget.events;
    }

    final visible = <CulturalEvent>[];

    for (int i = 0; i < 4; i++) {
      visible.add(
        widget.events[
        (_startIndex + i) % widget.events.length],
      );
    }

    return visible;
  }

  @override
  void initState() {
    super.initState();
    _startAutoRotation();
  }

  void _startAutoRotation() {
    if (!widget.autoRotate || widget.events.length <= 4) {
      return;
    }

    _rotationTimer?.cancel();

    _rotationTimer = Timer.periodic(
      widget.autoRotateDuration,
          (_) {
        if (!mounted) return;

        setState(() {
          _startIndex =
              (_startIndex + 1) % widget.events.length;
        });
      },
    );
  }

  @override
  void dispose() {
    _rotationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: AppShadows.cardSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cultural Events',
            style: AppTextStyles.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Discover traditions, celebrations and family heritage.',
            style: AppTextStyles.bodySmall(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: GridView.builder(
              key: ValueKey(_startIndex),
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: _visibleEvents.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (_, index) {
                final event = _visibleEvents[index];

                return _EventCard(
                  key: ValueKey(event.id),
                  event: event,
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onExplore,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.pill,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
              ),
              child: Text(
                'Explore More',
                style: AppTextStyles.bodySmall(
                  color: AppColors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatefulWidget {
  final CulturalEvent event;

  const _EventCard({
    super.key,
    required this.event,
  });

  @override
  State<_EventCard> createState() =>
      _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: isPressed ? 0.97 : 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.md,
            boxShadow: AppShadows.cardSoft,
          ),
          child: ClipRRect(
            borderRadius: AppRadius.md,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.event.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => Container(
                      color: AppColors.surfaceAlt,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.disabled,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.blackOpacity(0.70),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.white,
                          weight: FontWeight.w700,
                        ),
                      ),

                      if (widget.event.location != null)
                        ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.event.location!,
                            style:
                            AppTextStyles.caption(
                              color:
                              AppColors.whiteOpacity(
                                0.85,
                              ),
                            ),
                          ),
                        ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}