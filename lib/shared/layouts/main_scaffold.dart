// shared/layouts/main_scaffold.dart

import 'package:flutter/material.dart';

import '../../app/routes/app_router.dart';
import '../../app/routes/app_routes.dart';

import '../../features/home/widgets/app_side_drawer.dart';
import '../../features/home/widgets/home_header.dart';
import '../../features/home/widgets/premium_bottom_nav.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  /// Drawer
  final int drawerIndex;

  /// Bottom Navigation
  final int bottomNavIndex;

  final bool showHeader;
  final bool showBottomNav;

  const MainScaffold({
    super.key,
    required this.child,
    required this.drawerIndex,
    required this.bottomNavIndex,
    this.showHeader = true,
    this.showBottomNav = true,
  });

  // ==================================================
  // BOTTOM NAVIGATION
  // ==================================================

  void _onBottomNavTap(
      BuildContext context,
      int index,
      ) {
    switch (index) {
      case 0:
        AppRouter.clearAndPush(
          context,
          AppRoutes.home,
        );
        break;

      case 1:
        AppRouter.clearAndPush(
          context,
          AppRoutes.add,
        );
        break;

      case 2:
        AppRouter.push(
          context,
          AppRoutes.notifications,
        );
        break;
    }
  }

  // ==================================================
  // DRAWER NAVIGATION
  // ==================================================

  void _onDrawerNavigate(
      BuildContext context,
      int index,
      ) {
    switch (index) {
      case 0:
        AppRouter.clearAndPush(
          context,
          AppRoutes.home,
        );
        break;

      case 1:
        AppRouter.push(
          context,
          AppRoutes.familyTree,
        );
        break;

      case 2:
      // Memories
        break;

      case 3:
      // Timeline
        break;

      case 4:
      // Heritage
        break;

      case 5:
      // Stories
        break;

      case 6:
        AppRouter.push(
          context,
          AppRoutes.settings,
        );
        break;

      case 7:
      // Logout
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSideDrawer(
        currentIndex: drawerIndex,
        onNavigate: (index) =>
            _onDrawerNavigate(context, index),
      ),

      bottomNavigationBar: showBottomNav
          ? AppBottomNav(
        currentIndex: bottomNavIndex,
        onTap: (index) =>
            _onBottomNavTap(context, index),
      )
          : null,

      body: SafeArea(
        child: Column(
          children: [
            if (showHeader)
              const AppHeader(),

            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}