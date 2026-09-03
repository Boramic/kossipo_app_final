import 'package:flutter/material.dart';

import 'app_routes.dart';

/// =======================================================
/// KOSSIPO
/// APP PAGES
///
/// Central mapping between route names
/// and page builders.
///
/// Senior Architecture:
///
/// - Single Responsibility
/// - Easy maintenance
/// - RouteGuard ready
/// - DeepLink ready
/// - Firebase ready
/// =======================================================

abstract final class AppPages {
  AppPages._();

  static final Map<String, WidgetBuilder> routes = {
    //==================================================
    // INITIAL
    //==================================================

    AppRoutes.splash: (_) => const SizedBox(),

    AppRoutes.welcome: (_) => const SizedBox(),

    //==================================================
    // AUTH
    //==================================================

    AppRoutes.login: (_) => const SizedBox(),

    AppRoutes.signup: (_) => const SizedBox(),

    AppRoutes.otp: (_) => const SizedBox(),

    AppRoutes.forgotPassword: (_) => const SizedBox(),

    AppRoutes.resetPassword: (_) => const SizedBox(),

    AppRoutes.createProfile: (_) => const SizedBox(),

    //==================================================
    // MAIN
    //==================================================

    AppRoutes.home: (_) => const SizedBox(),

    AppRoutes.family: (_) => const SizedBox(),

    AppRoutes.village: (_) => const SizedBox(),

    AppRoutes.events: (_) => const SizedBox(),

    AppRoutes.gallery: (_) => const SizedBox(),

    AppRoutes.search: (_) => const SizedBox(),

    AppRoutes.notifications: (_) => const SizedBox(),

    AppRoutes.messages: (_) => const SizedBox(),

    //==================================================
    // PROFILE
    //==================================================

    AppRoutes.profile: (_) => const SizedBox(),

    AppRoutes.editProfile: (_) => const SizedBox(),

    //==================================================
    // SETTINGS
    //==================================================

    AppRoutes.settings: (_) => const SizedBox(),

    AppRoutes.privacy: (_) => const SizedBox(),

    AppRoutes.security: (_) => const SizedBox(),

    AppRoutes.about: (_) => const SizedBox(),

    AppRoutes.terms: (_) => const SizedBox(),

    //==================================================
    // ADMIN
    //==================================================

    AppRoutes.admin: (_) => const SizedBox(),

    //==================================================
    // ERROR
    //==================================================

    AppRoutes.notFound: (_) => const SizedBox(),
  };
}