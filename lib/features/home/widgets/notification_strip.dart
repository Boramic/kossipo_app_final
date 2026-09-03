import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';

class HomeNotificationStatus extends StatelessWidget {
  final List<NotificationStatusData> notifications;

  const HomeNotificationStatus({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: notifications.map((item) {
        return NotificationStatusItem(
          data: item,
        );
      }).toList(),
    );
  }
}

class NotificationStatusData {
  final String emoji;
  final Color color;
  final int count;
  final bool isUrgent;

  const NotificationStatusData({
    required this.emoji,
    required this.color,
    required this.count,
    this.isUrgent = false,
  });
}

class NotificationStatusItem
    extends StatefulWidget {
  final NotificationStatusData data;

  const NotificationStatusItem({
    super.key,
    required this.data,
  });

  @override
  State<NotificationStatusItem>
  createState() =>
      _NotificationStatusItemState();
}

class _NotificationStatusItemState
    extends State<NotificationStatusItem>
    with SingleTickerProviderStateMixin {
  late AnimationController
  _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController =
        AnimationController(
          vsync: this,
          duration: const Duration(
            milliseconds: 1400,
          ),
        );

    if (widget.data.isUrgent) {
      _pulseController.repeat(
        reverse: true,
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (_, child) {
        final scale =
        widget.data.isUrgent
            ? 1 +
            (_pulseController
                .value *
                0.08)
            : 1.0;

        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.data.color
                  .withValues(
                alpha: 0.12,
              ),
              border: Border.all(
                color: widget.data.color
                    .withValues(
                  alpha: 0.20,
                ),
              ),
              boxShadow:
              AppShadows.cardSoft,
            ),
            child: Center(
              child: Text(
                widget.data.emoji,
                style:
                const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),

          Positioned(
            top: -3,
            right: -3,
            child: AnimatedSwitcher(
              duration:
              const Duration(
                milliseconds: 350,
              ),
              transitionBuilder:
                  (
                  child,
                  animation,
                  ) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey(
                  widget.data.count,
                ),
                width: 18,
                height: 18,
                decoration:
                BoxDecoration(
                  color:
                  AppColors.white,
                  shape:
                  BoxShape.circle,
                  border: Border.all(
                    color:
                    AppColors
                        .background,
                    width: 1.5,
                  ),
                  boxShadow:
                  AppShadows
                      .cardSoft,
                ),
                child: Center(
                  child: Text(
                    "${widget.data.count}",
                    style:
                    const TextStyle(
                      fontSize: 8,
                      fontWeight:
                      FontWeight
                          .w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}