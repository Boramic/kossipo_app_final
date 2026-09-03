import 'package:flutter/material.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// COLOR PALETTE (CLEAN + STABLE)
// =======================================================

abstract final class AppColors {
  AppColors._();

  // ======================================================
  // 🌿 BRAND COLORS
  // ======================================================

  static const Color primaryGreen = Color(0xFF008000);
  static const Color secondaryGreen = Color(0xFFCCFFCC);
  static const Color accentGreen = Color(0xFF5CE65C);

  // ======================================================
  // 🌿 SURFACE
  // ======================================================

  static const Color background = Color(0xFFF6FBF6);
  static const Color surface = Colors.white;
  static const Color surfaceAlt = Color(0xFFEAF8EA);

  // ======================================================
  // 🖊 TEXT
  // ======================================================

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF4F4F4F);
  static const Color textMuted = Color(0xFF7A7A7A);

  static const Color textOnPrimary = Colors.white;
  static const Color textOnAccent = Colors.white;

  static const Color textGreen = Color(0xFF008000);

  // ======================================================
  // ⚡ STATUS
  // ======================================================

  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  static const Color success = Color(0xFF2E7D32);

  // ======================================================
  // 🔔 NOTIFICATIONS
  // ======================================================

  static const Color notificationUrgent = error;
  static const Color notificationNew = info;
  static const Color notificationImportant = warning;
  static const Color notificationNormal = Color(0xFF9E9E9E);

  // ======================================================
  // 🧱 BORDERS
  // ======================================================

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFF0F0F0);

  // ======================================================
  // 🚫 DISABLED
  // ======================================================

  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledBackground = Color(0xFFF2F2F2);

  // ======================================================
  // 🌿 BUTTONS
  // ======================================================

  static const Color buttonPrimary = primaryGreen;
  static const Color buttonSecondary = surface;
  static const Color buttonBorder = primaryGreen;

  // ======================================================
  // 🌫 SHADOW
  // ======================================================

  static const Color shadow = Color(0x1A000000);
  static const Color shadowGreen = Color(0x26008000);

  // ======================================================
  // 🧩 SAFE ALIASES (IMPORTANT FOR MIGRATION)
  // ======================================================

  static const Color primary = primaryGreen;
  static const Color secondary = secondaryGreen;
  static const Color white = Colors.white;
  static const Color black = Colors.black;


//========================================================
// 🎯 OPACITY HELPERS
//========================================================

  static Color primaryOpacity(double opacity) {
    return primaryGreen.withValues(alpha: opacity);
  }

  static Color accentOpacity(double opacity) {
    return accentGreen.withValues(alpha: opacity);
  }

  static Color blackOpacity(double opacity) {
    return Colors.black.withValues(alpha: opacity);
  }

  static Color whiteOpacity(double opacity) {
    return Colors.white.withValues(alpha: opacity);
  }

  //======================================================
// 🌿 INPUT STATES
//======================================================

  /// Focus (léger glow vert)
  static const Color inputFocus = Color(0xFF5CE65C);

  /// Success (validation réussie)
  static const Color inputSuccess = Color(0xFFB8F5B8);

  /// Success border
  static const Color inputSuccessBorder = Color(0xFF55C955);

  /// Error background
  static const Color inputError = Color(0xFFFFF2F2);

  /// Error border
  static const Color inputErrorBorder = Color(0xFFFF8A8A);

}