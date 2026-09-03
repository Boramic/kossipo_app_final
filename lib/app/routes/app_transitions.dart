import 'package:flutter/material.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP TRANSITIONS
///
/// Central Navigation Animation Engine
///
/// Senior Architecture
/// -----------------------------------
///
/// • Single Source of Truth
/// • Reusable
/// • Easy to maintain
/// • RouteGuard ready
/// • Firebase ready
/// • DeepLink ready
/// • Production Ready
///
/// =======================================================

abstract final class AppTransitions {
  AppTransitions._();

  //======================================================
  // GLOBAL CONFIGURATION
  //======================================================

  static const Duration duration =
  Duration(milliseconds: 300);

  static const Curve curve =
      Curves.easeInOutCubic;

  //======================================================
  // FADE
  //======================================================

  static PageRoute<T> fade<T>(
      Widget page,
      ) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,

      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  //======================================================
  // SLIDE RIGHT
  //======================================================

  static PageRoute<T> slideRight<T>(
      Widget page,
      ) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,

      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        final tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );

        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: child,
        );
      },
    );
  }

  //======================================================
  // SLIDE LEFT
  //======================================================

  static PageRoute<T> slideLeft<T>(
      Widget page,
      ) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,

      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        final tween = Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        );

        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: child,
        );
      },
    );
  }

  //======================================================
  // SLIDE BOTTOM
  //======================================================

  static PageRoute<T> slideBottom<T>(
      Widget page,
      ) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,

      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        final tween = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        );

        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: child,
        );
      },
    );
  }

  //======================================================
  // SCALE
  //======================================================

  static PageRoute<T> scale<T>(
      Widget page,
      ) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,

      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
          child: child,
        );
      },
    );
  }

  //======================================================
  // NONE
  //======================================================

  static PageRoute<T> none<T>(
      Widget page,
      ) {
    return MaterialPageRoute<T>(
      builder: (_) => page,
    );
  }
}