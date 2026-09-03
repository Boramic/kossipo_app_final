import 'package:flutter/material.dart';

import 'app_routes.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP ROUTE GUARD
///
/// SECURITY LAYER (AUTH + FLOW CONTROL)
///
/// RESPONSIBILITIES:
/// • Protect private routes
/// • Redirect unauthenticated users
/// • Prevent invalid navigation
/// • Prepare Firebase Auth integration
///
/// =======================================================

abstract final class AppRouteGuard {
  AppRouteGuard._();

  // =====================================================
  // SIMULATED AUTH STATE (replace with Firebase later)
  // =====================================================

  static bool _isLoggedIn = false;

  static bool get isLoggedIn => _isLoggedIn;

  static void setAuthState(bool value) {
    _isLoggedIn = value;
  }

  // =====================================================
  // PUBLIC ROUTES (accessible without login)
  // =====================================================

  static const List<String> publicRoutes = [
    AppRoutes.welcome,
    AppRoutes.login,
    AppRoutes.signup,
  ];

  // =====================================================
  // PROTECTED ROUTES (require login)
  // =====================================================

  static const List<String> protectedRoutes = [
    AppRoutes.home,
  ];

  // =====================================================
  // MAIN GUARD LOGIC
  // =====================================================

  static String? redirect(String route) {
    final loggedIn = isLoggedIn;

    // ---------------------------------------
    // CASE 1: NOT LOGGED IN
    // ---------------------------------------
    if (!loggedIn) {
      if (protectedRoutes.contains(route)) {
        return AppRoutes.welcome;
      }
      return null;
    }

    // ---------------------------------------
    // CASE 2: ALREADY LOGGED IN
    // ---------------------------------------
    if (loggedIn) {
      if (route == AppRoutes.login ||
          route == AppRoutes.signup ||
          route == AppRoutes.welcome) {
        return AppRoutes.home;
      }
    }

    return null;
  }
}