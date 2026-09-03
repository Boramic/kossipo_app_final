import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/layouts/main_scaffold.dart';

import '../memory/widgets/add_memory_sheet.dart';
import '../stories/pages/create_story_page.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "title": "Add Memory",
        "desc": "Store family moments",
        "icon": Icons.photo_library_rounded,
      },
      {
        "title": "Add Story",
        "desc": "Write a family story",
        "icon": Icons.auto_stories_rounded,
      },
      {
        "title": "Add Event",
        "desc": "Create family events",
        "icon": Icons.event_rounded,
      },
      {
        "title": "Invite Member",
        "desc": "Bring new relatives",
        "icon": Icons.group_add_rounded,
      },
      {
        "title": "Add Member",
        "desc": "Register a new person",
        "icon": Icons.person_add_alt_rounded,
      },
      {
        "title": "Add Timeline",
        "desc": "Create history lines",
        "icon": Icons.timeline_rounded,
      },
      {
        "title": "Add Village",
        "desc": "Link family origins",
        "icon": Icons.location_city_rounded,
      },
      {
        "title": "Add Branch",
        "desc": "Create family branches",
        "icon": Icons.account_tree_rounded,
      },
    ];

    return MainScaffold(
      drawerIndex: 0,
      bottomNavIndex: 1,
      child: Container(
        color: AppColors.background,
        child: GridView.builder(
          padding: const EdgeInsets.all(
            AppSpacing.md,
          ),
          itemCount: actions.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final action = actions[index];

            return _ActionHubCard(
              title: action["title"] as String,
              desc: action["desc"] as String,
              icon: action["icon"] as IconData,
              onTap: () {
                switch (index) {
                  case 0:
                    AddMemorySheet.open(context);
                    break;

                  case 1:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CreateStoryPage(),
                      ),
                    );
                    break;

                  case 2:
                    debugPrint("Add Event");
                    break;

                  case 3:
                    debugPrint("Invite Member");
                    break;

                  case 4:
                    debugPrint("Add Member");
                    break;

                  case 5:
                    debugPrint("Add Timeline");
                    break;

                  case 6:
                    debugPrint("Add Village");
                    break;

                  case 7:
                    debugPrint("Add Branch");
                    break;
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _ActionHubCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionHubCard({
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_ActionHubCard> createState() =>
      _ActionHubCardState();
}

class _ActionHubCardState
    extends State<_ActionHubCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,

      onTapDown: (_) =>
          setState(() => pressed = true),

      onTapUp: (_) =>
          setState(() => pressed = false),

      onTapCancel: () =>
          setState(() => pressed = false),

      child: AnimatedScale(
        duration:
        const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        scale: pressed ? 0.97 : 1,
        child: Container(
          padding:
          const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
            BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                color: AppColors.primaryGreen
                    .withValues(alpha: .08),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                size: 30,
                color: AppColors.primaryGreen,
              ),

              const Spacer(),

              Text(
                widget.title,
                style: AppTextStyles.bodySmall(
                  weight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.desc,
                style: AppTextStyles.caption(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}