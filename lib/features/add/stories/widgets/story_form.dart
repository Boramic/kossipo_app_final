import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../shared/inputs/app_text_field.dart';
import '../../../../shared/inputs/multiline_field.dart';

import '../controllers/story_controller.dart';

class StoryForm extends StatefulWidget {
  const StoryForm({
    super.key,
    required this.controller,
  });

  final StoryController controller;

  @override
  State<StoryForm> createState() =>
      _StoryFormState();
}

class _StoryFormState
    extends State<StoryForm> {
  late final TextEditingController
  _titleController;

  late final TextEditingController
  _contentController;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController();

    _contentController =
        TextEditingController();

    widget.controller.addListener(
      _refresh,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _refresh,
    );

    _titleController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft =
        widget.controller.draft;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.all(
              AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color:
              AppColors.primaryGreen
                  .withValues(
                alpha: .08,
              ),
              borderRadius:
              BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.auto_stories_rounded,
                  size: 48,
                  color:
                  AppColors.primaryGreen,
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  draft.isQuote
                      ? 'Share a family quote'
                      : 'Tell a family story',
                  style:
                  AppTextStyles.body(
                    weight:
                    FontWeight.w700,
                  ),
                  textAlign:
                  TextAlign.center,
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  draft.isQuote
                      ? 'A sentence can inspire generations.'
                      : 'Preserve a memory for future generations.',
                  textAlign:
                  TextAlign.center,
                  style:
                  AppTextStyles.caption(
                    color: AppColors
                        .textMuted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
              BorderRadius.circular(
                18,
              ),
            ),
            child: SwitchListTile(
              value: draft.isQuote,
              activeThumbColor:
              AppColors.primaryGreen,
              title: Text(
                'Quote Mode',
                style:
                AppTextStyles.bodyMedium(
                  weight:
                  FontWeight.w600,
                ),
              ),
              subtitle: Text(
                draft.isQuote
                    ? 'This will be saved as a quote.'
                    : 'This will be saved as a story.',
                style:
                AppTextStyles.caption(
                  color: AppColors
                      .textMuted,
                ),
              ),
              onChanged:
              widget.controller
                  .setIsQuote,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          AppTextField(
            controller:
            _titleController,
            hintText:
            draft.isQuote
                ? 'Quote title'
                : 'Story title',
            onChanged:
            widget.controller
                .setTitle,
          ),

          const SizedBox(
            height: 20,
          ),

          AppMultilineField(
            controller:
            _contentController,
            label:
            draft.isQuote
                ? 'Quote'
                : 'Story',
            hintText:
            draft.isQuote
                ? 'Write a meaningful quote...'
                : 'Tell your family story...',
            maxLength: 5000,
            onChanged:
            widget.controller
                .setContent,
          ),

          const SizedBox(
            height: 12,
          ),

          Align(
            alignment:
            Alignment.centerRight,
            child: Text(
              '${draft.contentLength} characters',
              style:
              AppTextStyles.caption(
                color:
                AppColors.textMuted,
              ),
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          Container(
            padding:
            const EdgeInsets.all(
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color:
              Colors.amber.shade50,
              borderRadius:
              BorderRadius.circular(
                18,
              ),
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Text(
                    draft.isQuote
                        ? 'Quotes help preserve wisdom, values and memorable words from family members.'
                        : 'Stories preserve traditions, experiences and family history for future generations.',
                    style:
                    AppTextStyles.caption(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}