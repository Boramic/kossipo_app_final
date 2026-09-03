import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../controllers/family_tree_controller.dart';

class FamilyMemberBottomSheet extends StatelessWidget {
  final FamilyTreeController controller;

  const FamilyMemberBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final member = controller.selectedMember;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      offset: member == null
          ? const Offset(0, 1.2)
          : Offset.zero,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: member == null ? 0 : 1,
        child: member == null
            ? const SizedBox.shrink()
            : Container(
          height:
          MediaQuery.of(context).size.height * 0.42,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.12,
                ),
                blurRadius: 24,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius:
                  BorderRadius.circular(50),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics:
                  const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.all(
                    AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundImage:
                            NetworkImage(
                              member.imageUrl,
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
                                  member.fullName,
                                  style: AppTextStyles
                                      .titleLarge(),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  member.relationship,
                                  style: AppTextStyles
                                      .bodySmall(),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: controller
                                .clearSelection,
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      _InfoTile(
                        icon: Icons.cake,
                        label:
                        "Born: ${member.birthDate}",
                      ),

                      _InfoTile(
                        icon: Icons.work,
                        label: member.profession,
                      ),

                      _InfoTile(
                        icon: Icons.favorite,
                        label:
                        member.maritalStatus,
                      ),

                      _InfoTile(
                        icon: Icons.location_on,
                        label: member.location,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      Text(
                        "Memories",
                        style: AppTextStyles
                            .titleMedium(),
                      ),

                      const SizedBox(
                        height: AppSpacing.md,
                      ),

                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection:
                          Axis.horizontal,
                          itemCount:
                          member.memories.length,
                          separatorBuilder:
                              (_, __) =>
                          const SizedBox(
                            width: AppSpacing.sm,
                          ),
                          itemBuilder:
                              (context, index) {
                            final image =
                            member.memories[index];

                            return ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                              child: Image.network(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      Text(
                        "Biography",
                        style: AppTextStyles
                            .titleMedium(),
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        member.biography,
                        style:
                        AppTextStyles.body(),
                      ),
                    ],
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTile({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primaryGreen,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body(),
            ),
          ),
        ],
      ),
    );
  }
}