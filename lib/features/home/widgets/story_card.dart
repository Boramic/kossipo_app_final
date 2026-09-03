import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class StoryCard extends StatefulWidget {
  final List<Map<String, String>> stories;
  final VoidCallback? onAddStory;

  const StoryCard({
    super.key,
    required this.stories,
    this.onAddStory,
  });

  @override
  State<StoryCard> createState() =>
      _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  int _currentIndex = 0;
  bool _isExpanded = false;

  Timer? _storyTimer;
  Timer? _progressTimer;

  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _startStoryLoop();
  }

  void _startStoryLoop() {
    _progressTimer?.cancel();
    _storyTimer?.cancel();

    _progress = 0;

    _progressTimer = Timer.periodic(
      const Duration(milliseconds: 180),
          (timer) {
        if (!mounted) return;

        setState(() {
          _progress += 0.02;
        });

        if (_progress >= 1) {
          timer.cancel();
        }
      },
    );

    _storyTimer = Timer(
      const Duration(seconds: 9),
          () {
        if (!mounted ||
            widget.stories.isEmpty) return;

        setState(() {
          _currentIndex =
              (_currentIndex + 1) %
                  widget.stories.length;

          _isExpanded = false;
        });

        _startStoryLoop();
      },
    );
  }

  @override
  void dispose() {
    _storyTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stories.isEmpty) {
      return _emptyCard();
    }

    final story =
    widget.stories[_currentIndex];

    final text = story["text"] ?? "";
    final isLong = text.length > 140;

    return AnimatedContainer(
      duration:
      const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      child: AnimatedSwitcher(
        duration:
        const Duration(milliseconds: 650),
        child: Container(
          key: ValueKey(story["text"]),
          width: double.infinity,
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppRadius.card,
            boxShadow: AppShadows.cardSoft,
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryGreen,
                          AppColors.accentGreen,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        story["author"]![0]
                            .toUpperCase(),
                        style:
                        AppTextStyles.bodySmall(
                          color:
                          AppColors.white,
                          weight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: AppSpacing.md,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          story["author"]!,
                          style:
                          AppTextStyles.bodySmall(
                            weight:
                            FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Family Story",
                          style:
                          AppTextStyles.caption(
                            color: AppColors
                                .textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              ClipRRect(
                borderRadius:
                AppRadius.pill,
                child:
                LinearProgressIndicator(
                  value: _progress,
                  minHeight: 6,
                  backgroundColor:
                  AppColors.surfaceAlt,
                  valueColor:
                  AlwaysStoppedAnimation(
                    AppColors.primaryGreen,
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              AnimatedSize(
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeInOut,
                child: Text(
                  text,
                  maxLines:
                  _isExpanded ? null : 4,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: AppTextStyles.body(
                    color: AppColors
                        .textSecondary,
                  ),
                ),
              ),

              if (isLong)
                Align(
                  alignment:
                  Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded =
                        !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded
                          ? "Show less"
                          : "More",
                    ),
                  ),
                ),

              const SizedBox(
                height: AppSpacing.sm,
              ),

              Align(
                alignment:
                Alignment.bottomRight,
                child: GestureDetector(
                  onTap:
                  widget.onAddStory,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration:
                    BoxDecoration(
                      gradient:
                      LinearGradient(
                        colors: [
                          AppColors
                              .primaryGreen,
                          AppColors
                              .accentGreen,
                        ],
                      ),
                      shape:
                      BoxShape.circle,
                      boxShadow:
                      AppShadows.bottomNav,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 20,
                      color:
                      AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyCard() {
    return Container(
      padding:
      const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
        AppRadius.card,
        boxShadow:
        AppShadows.cardSoft,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 34,
          ),
          const SizedBox(height: 10),
          Text(
            "No family stories yet",
            style:
            AppTextStyles.bodySmall(),
          ),
        ],
      ),
    );
  }
}