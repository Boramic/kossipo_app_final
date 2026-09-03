import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../shared/layouts/main_scaffold.dart';

import '../controllers/event_controller.dart';
import '../repositories/event_repository.dart';
import '../widgets/event_form.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({
    super.key,
    required this.familyId,
    required this.authorId,
  });

  final String familyId;
  final String authorId;

  @override
  State<CreateEventPage> createState() =>
      _CreateEventPageState();
}

class _CreateEventPageState
    extends State<CreateEventPage> {
  late final EventController _controller;

  late final EventRepository _repository;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _controller = EventController();

    _repository = EventRepository();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<void> _saveEvent() async {
    if (!_controller.isValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please complete all required fields.',
          ),
        ),
      );

      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await _repository.createEvent(
        familyId: widget.familyId,
        authorId: widget.authorId,
        draft: _controller.draft,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Event created successfully.',
          ),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Unable to create event: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      drawerIndex: 0,
      bottomNavIndex: 1,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  color: AppColors.primaryGreen
                      .withValues(
                    alpha: .06,
                  ),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),

                  Expanded(
                    child: Text(
                      'Create Event',
                      style:
                      AppTextStyles.titleLarge(),
                      textAlign:
                      TextAlign.center,
                    ),
                  ),

                  const SizedBox(
                    width: 48,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: EventForm(
              controller: _controller,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  color: AppColors.primaryGreen
                      .withValues(
                    alpha: .06,
                  ),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                  _saving
                      ? null
                      : _saveEvent,
                  child:
                  _saving
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Create Event',
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