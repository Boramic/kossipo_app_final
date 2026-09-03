import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../routes/app_transitions.dart';

// PAGES
import '../../features/onboarding/pages/welcome_page.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/onboarding/pages/family_gateway_page.dart';
import '../../features/onboarding/pages/family_name_page.dart';
import '../../features/onboarding/pages/country_page.dart';
import '../../features/onboarding/pages/village_page.dart';
import '../../features/onboarding/pages/join_family_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/family_tree/pages/family_tree_page.dart';
import '../../features/add/pages/add_page.dart';

/// =======================================================
/// APP ROUTER (SINGLE SOURCE OF TRUTH)
/// =======================================================
/// - Routes
/// - Pages
/// - Transitions
/// - Future: Auth Guard, Deep links
/// =======================================================

abstract final class AppRouter {
  AppRouter._();

  /// ================================
  /// ROUTE GENERATOR (MAIN ENTRY)
  /// ================================
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = settings.name ?? AppRoutes.welcome;

    switch (route) {
    // ---------------- WELCOME ----------------
      case AppRoutes.welcome:
        return AppTransitions.fade(const WelcomePage());

    // ---------------- LOGIN ----------------
      case AppRoutes.login:
        return AppTransitions.slideRight(
          const SignInPage(),
        );

    // ---------------- SIGNUP ----------------
      case AppRoutes.signup:
        return AppTransitions.slideRight(
          const SignUpPage(),
        );

      case AppRoutes.familyName:
        return AppTransitions.slideRight(
          const FamilyNamePage(),
        );

      case AppRoutes.country:
        return AppTransitions.slideRight(
          const CountryPage(),
        );

      case AppRoutes.village:
        return AppTransitions.slideRight(
          const VillagePage(),
        );

      case AppRoutes.familyGateway:
        return AppTransitions.slideRight(
          const FamilyGatewayPage(),
        );

      case AppRoutes.joinFamily:
        return MaterialPageRoute(
          builder: (_) => const JoinFamilyPage(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case AppRoutes.add:
        return MaterialPageRoute(
          builder: (_) => const AddPage(),
        );

      case AppRoutes.familyTree:
        return MaterialPageRoute(
          builder: (_) => const FamilyTreePage(),
        );


    // ---------------- DEFAULT ----------------
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Route not found"),
            ),
          ),
        );
    }
  }

  /// ================================
  /// NAVIGATION API (CLEAN)
  /// ================================

  static Future<T?> push<T>(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushNamed<T>(
      route,
      arguments: arguments,
    );
  }

  static Future<T?> replace<T>(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushReplacementNamed<T, T>(
      route,
      arguments: arguments,
    );
  }

  static Future<T?> clearAndPush<T>(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      route,
          (route) => false,
      arguments: arguments,
    );
  }

  static void back(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}