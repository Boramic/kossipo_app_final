import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class FamilyEventModel {
  final String title;
  final String image;
  final String date;

  const FamilyEventModel({
    required this.title,
    required this.image,
    required this.date,
  });
}

class FamilyEventsPreview extends StatelessWidget {
  final List<FamilyEventModel> events;

  const FamilyEventsPreview({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return _EmptyEventCard();
    }

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final event = events[index];

          return _EventCard(event: event);
        },
      ),
    );
  }
}

class _EventCard extends StatefulWidget {
  final FamilyEventModel event;

  const _EventCard({
    required this.event,
  });

  @override
  State<_EventCard> createState() =>
      _EventCardState();
}

class _EventCardState
    extends State<_EventCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) =>
          setState(() => isPressed = true),
      onTapUp: (_) =>
          setState(() => isPressed = false),
      onTapCancel: () =>
          setState(() => isPressed = false),
      child: AnimatedScale(
        duration:
        const Duration(milliseconds: 180),
        scale: isPressed ? .97 : 1,
        child: Container(
          width: 145,
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            boxShadow: [
              ...AppShadows.cardSoft,
              BoxShadow(
                blurRadius: 18,
                color: AppColors.primaryGreen
                    .withValues(alpha: .08),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: AppRadius.card,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    widget.event.image,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin:
                        Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.black
                              .withValues(
                            alpha: .65,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.title,
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style:
                        AppTextStyles.bodySmall(
                          color: AppColors.white,
                          weight:
                          FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        widget.event.date,
                        style:
                        AppTextStyles.caption(
                          color: AppColors.white
                              .withValues(
                            alpha: .85,
                          ),
                        ),
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
  }
}

class _EmptyEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.cardSoft,
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy_rounded,
            color: AppColors.textMuted,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(
            "No family events yet",
            style: AppTextStyles.bodySmall(
              color: AppColors.textMuted,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}