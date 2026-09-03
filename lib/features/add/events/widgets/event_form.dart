import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

import '../controllers/event_controller.dart';
import 'event_date_picker.dart';
import 'event_type_selector.dart';

class EventForm extends StatelessWidget {
  const EventForm({
    super.key,
    required this.controller,
  });

  final EventController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // ----------------------------------------
              // EVENT TYPE
              // ----------------------------------------

              EventTypeSelector(
                selectedType:
                controller.draft.type,
                onChanged:
                controller.updateType,
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              // ----------------------------------------
              // TITLE
              // ----------------------------------------

              TextFormField(
                initialValue:
                controller.draft.title,
                decoration: InputDecoration(
                  labelText: 'Event Title',
                  hintText:
                  'Family reunion, wedding...',
                  errorText:
                  controller.titleError,
                ),
                textCapitalization:
                TextCapitalization.words,
                onChanged:
                controller.updateTitle,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              // ----------------------------------------
              // DESCRIPTION
              // ----------------------------------------

              TextFormField(
                initialValue:
                controller.draft.description,
                minLines: 4,
                maxLines: 8,
                decoration:
                const InputDecoration(
                  labelText: 'Description',
                  hintText:
                  'Tell family members about this event...',
                ),
                onChanged:
                controller.updateDescription,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              // ----------------------------------------
              // LOCATION
              // ----------------------------------------

              TextFormField(
                initialValue:
                controller.draft.location,
                decoration:
                const InputDecoration(
                  labelText: 'Location',
                  hintText:
                  'Village, city, venue...',
                ),
                onChanged:
                controller.updateLocation,
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              // ----------------------------------------
              // ALL DAY EVENT
              // ----------------------------------------

              SwitchListTile(
                value:
                controller.draft.isAllDay,
                title: const Text(
                  'All Day Event',
                ),
                contentPadding:
                EdgeInsets.zero,
                onChanged:
                controller.toggleAllDay,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              // ----------------------------------------
              // DATE PICKER
              // ----------------------------------------

              EventDatePicker(
                startDate:
                controller.draft.startDate,
                endDate:
                controller.draft.endDate,
                isAllDay:
                controller.draft.isAllDay,
                onStartDateChanged:
                controller.updateStartDate,
                onEndDateChanged:
                controller.updateEndDate,
              ),

              if (controller.dateError != null)
                Padding(
                  padding:
                  const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Text(
                    controller.dateError!,
                    style: TextStyle(
                      color:
                      Theme.of(context)
                          .colorScheme
                          .error,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(
                height: AppSpacing.xl,
              ),
            ],
          ),
        );
      },
    );
  }
}