import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class AppSideDrawer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavigate;

  const AppSideDrawer({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  static const Color drawerGreen =
  Color(0xFF19C56B);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Container(
            color: drawerGreen,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  _buildHeader(),

                  const SizedBox(height: 30),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      children: [
                        _navItem(
                          context,
                          icon: Icons.home_rounded,
                          title: "Home",
                          index: 0,
                        ),
                        _navItem(
                          context,
                          icon: Icons.account_tree_rounded,
                          title: "Family Tree",
                          index: 1,
                        ),
                        _navItem(
                          context,
                          icon: Icons.favorite_rounded,
                          title: "Memories",
                          index: 2,
                        ),
                        _navItem(
                          context,
                          icon: Icons.timeline_rounded,
                          title: "Timeline",
                          index: 3,
                        ),
                        _navItem(
                          context,
                          icon: Icons.public_rounded,
                          title: "Heritage",
                          index: 4,
                        ),
                        _navItem(
                          context,
                          icon: Icons.menu_book_rounded,
                          title: "Stories",
                          index: 5,
                        ),
                        _navItem(
                          context,
                          icon: Icons.settings_rounded,
                          title: "Settings",
                          index: 6,
                        ),

                        const SizedBox(height: 20),

                        Divider(
                          color: Colors.white.withValues(
                            alpha: .18,
                          ),
                        ),

                        _navItem(
                          context,
                          icon: Icons.logout_rounded,
                          title: "Sign out",
                          index: 7,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white24,
          backgroundImage: const AssetImage(
            "assets/images/profile.jpg",
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Waffo Foka Borel",
          style: AppTextStyles.titleMedium(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "wborl020@gmail.com",
          style: AppTextStyles.bodySmall(
            color: Colors.white.withValues(
              alpha: .85,
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required int index,
      }) {
    final bool active = currentIndex == index;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.pill,
          onTap: () {
            Navigator.pop(context);
            onNavigate(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: active
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: AppRadius.pill,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: active
                      ? drawerGreen
                      : Colors.white,
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    color: active
                        ? drawerGreen
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}