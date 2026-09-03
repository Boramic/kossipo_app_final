/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// RADIUS SCALE (UI SHAPE SYSTEM)
/// =======================================================

import 'package:flutter/material.dart';

abstract class AppRadius {
  AppRadius._();

  // ======================================================
  // 📐 BASE RADIUS SCALE
  // ======================================================

  /// Small radius (chips, badges, tags)
  static const BorderRadius xs = BorderRadius.all(Radius.circular(8));

  /// Default small UI elements (buttons)
  static const BorderRadius sm = BorderRadius.all(Radius.circular(12));

  /// Medium radius (inputs, cards, standard containers)
  static const BorderRadius md = BorderRadius.all(Radius.circular(16));

  /// Large radius (feature cards, banners)
  static const BorderRadius lg = BorderRadius.all(Radius.circular(24));

  /// Extra large radius (hero sections, onboarding panels)
  static const BorderRadius xl = BorderRadius.all(Radius.circular(32));

  // ======================================================
  // 🧱 nav bottom navigation
  // ======================================================
  static const BorderRadius bottomNav =
  BorderRadius.all(Radius.circular(24));

  // ======================================================
  // 🧱 SPECIAL SHAPES
  // ======================================================

  /// Fully rounded buttons (pill shape)
  static const BorderRadius pill =
  BorderRadius.all(Radius.circular(50));

  /// Circular elements (avatars, icons)
  static const BorderRadius circle =
  BorderRadius.all(Radius.circular(999));

  // ======================================================
  // 📱 SEMANTIC USAGE (SENIOR ABSTRACTION)
  // ======================================================

  /// Default button radius (PRIMARY ACTIONS)
  static const BorderRadius button = sm;

  /// Input fields radius
  static const BorderRadius input = md;

  /// Card radius (default containers)
  static const BorderRadius card = md;

  /// Modal / dialog radius
  static const BorderRadius dialog = lg;

  /// Onboarding / hero UI radius
  static const BorderRadius onboarding = xl;
}