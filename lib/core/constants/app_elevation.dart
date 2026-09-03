import 'package:flutter/material.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// ELEVATION / SHADOW SYSTEM (3D DEPTH)
/// =======================================================

abstract final class AppElevation {
  AppElevation._();

  // ======================================================
  // 🌱 BASE (NO SHADOW)
  // ======================================================
  static const List<BoxShadow> none = [];

  // ======================================================
  // 🌿 LEVEL 1 — very soft (cards, inputs)
  // ======================================================
  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  // ======================================================
  // 🌿 LEVEL 2 — soft floating (buttons, cards hover)
  // ======================================================
  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x14000000), // 8% black
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  // ======================================================
  // 🌿 LEVEL 3 — medium elevation (cards important UI)
  // ======================================================
  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x1F000000), // 12% black
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  // ======================================================
  // 🌿 LEVEL 4 — strong elevation (modals, dropdowns)
  // ======================================================
  static const List<BoxShadow> level4 = [
    BoxShadow(
      color: Color(0x26000000), // 15% black
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  // ======================================================
  // 🌿 LEVEL 5 — premium floating (floating buttons, hero UI)
  // ======================================================
  static const List<BoxShadow> level5 = [
    BoxShadow(
      color: Color(0x33000000), // 20% black
      blurRadius: 32,
      offset: Offset(0, 14),
    ),
  ];

  // ======================================================
  // 🌿 LEVEL 6 — extreme depth (dialogs, overlays)
  // ======================================================
  static const List<BoxShadow> level6 = [
    BoxShadow(
      color: Color(0x40000000), // 25% black
      blurRadius: 40,
      offset: Offset(0, 18),
    ),
  ];

  // ======================================================
  // 🌿 GREEN BRAND GLOW (KOSSIPO SIGNATURE)
  // ======================================================
  static const List<BoxShadow> greenGlow = [
    BoxShadow(
      color: Color(0x33008000), // primary green glow
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
  ];

  // ======================================================
  // ⚡ PRESSED STATE (3D CLICK EFFECT)
  // ======================================================
  static const List<BoxShadow> pressed = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  // ======================================================
  // 🎯 SEMANTIC ELEVATIONS (Recommended aliases)
  // ======================================================

  /// Buttons (Primary, Secondary, Ghost...)
  static const List<BoxShadow> button = level2;

  /// Button when pressed
  static const List<BoxShadow> buttonPressed = pressed;

  /// Standard Cards
  static const List<BoxShadow> card = level1;

  /// Elevated Cards
  static const List<BoxShadow> cardElevated = level3;

  /// Dialogs & BottomSheets
  static const List<BoxShadow> dialog = level5;

  /// Floating elements (FAB, Menus...)
  static const List<BoxShadow> floating = level4;

  /// Kossipo premium green effect
  static const List<BoxShadow> brandGlow = greenGlow;
}