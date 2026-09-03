import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../controllers/family_tree_controller.dart';
import '../models/family_member_model.dart';

class FamilySearchResults extends StatelessWidget {
  final FamilyTreeController controller;

  const FamilySearchResults({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final results = controller.filteredMembers;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: !controller.isSearching
          ? const SizedBox.shrink()
          : Container(
        key: const ValueKey('search_results'),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(
          top: AppSpacing.sm,
        ),
        child: results.isEmpty
            ? const _EmptyResults()
            : ListView.separated(
          physics:
          const BouncingScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (_, __) =>
          const SizedBox(
            height: AppSpacing.sm,
          ),
          itemBuilder: (context, index) {
            final member = results[index];

            return _SearchResultTile(
              member: member,
              controller: controller,
            );
          },
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final FamilyMemberModel member;
  final FamilyTreeController controller;

  const _SearchResultTile({
    required this.member,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadius.card,
        onTap: () {
          controller.clearSearch();
          controller.focusOnMember(member.id);
          controller.selectMember(member);
        },
        child: Ink(
          padding: const EdgeInsets.all(
            AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.card,
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage:
                NetworkImage(member.imageUrl),
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
                      member.fullName,
                      style:
                      AppTextStyles.titleSmall(),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      member.relationship,
                      style:
                      AppTextStyles.bodySmall(),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${member.birthDate.day}/${member.birthDate.month}/${member.birthDate.year}",
                      style: AppTextStyles.caption(),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen
                      .withValues(alpha: 0.08),
                  borderRadius:
                  AppRadius.pill,
                ),
                child: Text(
                  "Gen ${member.generation}",
                  style: AppTextStyles.caption(
                    color:
                    AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 52,
            color: AppColors.textMuted,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            "No family member found",
            style: AppTextStyles.titleSmall(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}