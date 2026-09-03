import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../routes/app_router.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP START
///
/// Entry Decision Layer
///
/// RESPONSIBILITIES:
/// • Decide initial screen
/// • Handle future auth logic
/// • Handle onboarding logic
/// • Keep main.dart clean
///
/// =======================================================

abstract final class AppStart {
  AppStart._();

  /// Simulated auth state (later Firebase will replace this)
  static bool _isLoggedIn = false;

  /// You can later replace this with:
  /// FirebaseAuth.instance.currentUser != null
  static Future<bool> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _isLoggedIn;
  }

  /// MAIN ENTRY DECISION
  static Future<String> getInitialRoute() async {
    final loggedIn = await checkAuth();

    if (loggedIn) {
      return AppRoutes.home;
    } else {
      return AppRoutes.welcome;
    }
  }

  /// DEV ONLY (for testing flow)
  static void setLoggedIn(bool value) {
    _isLoggedIn = value;
  }
}