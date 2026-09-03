import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class EventDatePicker extends StatelessWidget {
  const EventDatePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.isAllDay,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final bool isAllDay;

  final ValueChanged<DateTime>
  onStartDateChanged;

  final ValueChanged<DateTime>
  onEndDateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Event Schedule',
          style: AppTextStyles.bodyMedium(
            weight: FontWeight.w700,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        _DateCard(
          icon: Icons.play_circle_outline,
          title: 'Start',
          date: startDate,
          isAllDay: isAllDay,
          onTap: () async {
            final result =
            await _pickDateTime(
              context,
              initialDate:
              startDate ??
                  DateTime.now(),
              isAllDay: isAllDay,
            );

            if (result != null) {
              onStartDateChanged(
                result,
              );
            }
          },
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        _DateCard(
          icon: Icons.flag_outlined,
          title: 'End',
          date: endDate,
          isAllDay: isAllDay,
          onTap: () async {
            final result =
            await _pickDateTime(
              context,
              initialDate:
              endDate ??
                  startDate ??
                  DateTime.now(),
              isAllDay: isAllDay,
            );

            if (result != null) {
              onEndDateChanged(
                result,
              );
            }
          },
        ),
      ],
    );
  }

  Future<DateTime?> _pickDateTime(
      BuildContext context, {
        required DateTime initialDate,
        required bool isAllDay,
      }) async {
    final pickedDate =
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (!context.mounted) {
      return null;
    }

    if (pickedDate == null) {
      return null;
    }

    if (isAllDay) {
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
    }

    final pickedTime =
    await showTimePicker(
      context: context,
      initialTime:
      TimeOfDay.fromDateTime(
        initialDate,
      ),
    );

    if (!context.mounted) {
      return null;
    }

    if (pickedTime == null) {
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
    }

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.icon,
    required this.title,
    required this.date,
    required this.isAllDay,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final DateTime? date;
  final bool isAllDay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
      BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors
                    .primaryGreen
                    .withValues(
                  alpha: .10,
                ),
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),
              child: Icon(
                icon,
                color:
                AppColors.primaryGreen,
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                    AppTextStyles.caption(
                      color:
                      AppColors.textMuted,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    _formatDate(date),
                    style:
                    AppTextStyles.bodySmall(
                      weight:
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(
      DateTime? date,
      ) {
    if (date == null) {
      return 'Select date';
    }

    final day =
    date.day.toString().padLeft(
      2,
      '0',
    );

    final month =
    date.month.toString().padLeft(
      2,
      '0',
    );

    final year = date.year;

    final hour =
    date.hour.toString().padLeft(
      2,
      '0',
    );

    final minute =
    date.minute.toString().padLeft(
      2,
      '0',
    );

    if (isAllDay) {
      return '$day/$month/$year';
    }

    return '$day/$month/$year • $hour:$minute';
  }
}