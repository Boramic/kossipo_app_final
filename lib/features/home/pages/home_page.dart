import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../shared/layouts/main_scaffold.dart';

import '../data/home_demo_data.dart';

import '../widgets/hero_banner.dart';
import '../widgets/notification_strip.dart';
import '../widgets/home_shortcuts.dart';
import '../widgets/family_memory_carousel.dart';
import '../widgets/section_title.dart';
import '../widgets/family_events_preview.dart';
import '../widgets/story_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// ==========================================
  /// OPEN FAMILY TREE
  /// ==========================================
  void _openFamilyTree() {
    AppRouter.push(
      context,
      AppRoutes.familyTree,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      drawerIndex: 0,
      bottomNavIndex: 0,
      child: Column(
        children: [
          const SizedBox(
            height: AppSpacing.sm,
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  HomeHeroBanner(
                    imageUrl:
                    "assets/images/family_tree_preview.jpg",
                    title:
                    "Discover Your Family Tree",
                    subtitle:
                    "Explore your roots and legacy.",
                    onExplore: _openFamilyTree,
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  HomeNotificationStatus(
                    notifications:
                    demoNotifications,
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  const HomeShortcuts(),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  const SectionTitle(
                    title: "Family Memories",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  FamilyMemoryCarousel(
                    memories: demoMemories,
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  const SectionTitle(
                    title: "Family Events",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  FamilyEventsPreview(
                    events: demoEventsPreview,
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  const SectionTitle(
                    title: "Family Stories",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  StoryCard(
                    stories: demoStories,
                    onAddStory: () {
                      AppRouter.push(
                        context,
                        AppRoutes.add,
                      );
                    },
                  ),

                  const SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}