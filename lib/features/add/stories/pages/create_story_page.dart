import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../shared/layouts/main_scaffold.dart';

import '../controllers/story_controller.dart';
import '../repositories/story_repository.dart';
import '../widgets/story_form.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({
    super.key,
  });

  @override
  State<CreateStoryPage> createState() =>
      _CreateStoryPageState();
}

class _CreateStoryPageState
    extends State<CreateStoryPage> {
  late final StoryController _controller;

  late final StoryRepository _repository;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _controller = StoryController();

    _repository = StoryRepository();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<void> _saveStory() async {
    if (!_controller.draft.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
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
      final currentUser =
          FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception(
          'User not authenticated.',
        );
      }

      final userDoc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data();

      if (userData == null) {
        throw Exception(
          'User profile not found.',
        );
      }

      final familyId =
      userData['familyId'] as String?;

      if (familyId == null ||
          familyId.isEmpty) {
        throw Exception(
          'User is not linked to a family.',
        );
      }

      await _repository.createStory(
        familyId: familyId,
        authorId: currentUser.uid,
        draft: _controller.draft,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _controller.draft.isQuote
                ? 'Quote saved successfully.'
                : 'Story saved successfully.',
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
            'Unable to save story: $e',
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
                      'Create Story',
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
            child: StoryForm(
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
                  onPressed: _saving
                      ? null
                      : _saveStory,
                  child: _saving
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    _controller
                        .draft.isQuote
                        ? 'Save Quote'
                        : 'Save Story',
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