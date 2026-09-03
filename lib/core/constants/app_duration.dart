import 'package:flutter/material.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP DURATIONS
/// =======================================================
///
/// Toutes les animations de l'application doivent utiliser
/// ces constantes afin de garantir une expérience uniforme.
///
/// ❌ Mauvais :
///
/// Duration(milliseconds: 250)
///
/// ✅ Bon :
///
/// AppDuration.medium
///
/// =======================================================

abstract final class AppDuration {
  AppDuration._();

  //========================================================
  // ⚡ MICRO INTERACTIONS
  //========================================================

  /// Press effect
  static const Duration instant =
  Duration(milliseconds: 80);

  /// Button press
  static const Duration fast =
  Duration(milliseconds: 120);

  /// Small UI transition
  static const Duration short =
  Duration(milliseconds: 180);

  //========================================================
  // 🌿 STANDARD ANIMATIONS
  //========================================================

  /// Default animation
  static const Duration medium =
  Duration(milliseconds: 250);

  /// Card animation
  static const Duration normal =
  Duration(milliseconds: 300);

  //========================================================
  // 🎬 COMPLEX ANIMATIONS
  //========================================================

  /// Page transition
  static const Duration long =
  Duration(milliseconds: 450);

  /// Hero animation
  static const Duration slow =
  Duration(milliseconds: 600);

  /// Splash / Intro
  static const Duration extraSlow =
  Duration(milliseconds: 900);

  //========================================================
  // ⏱ DELAYS
  //========================================================

  /// Small delay
  static const Duration delayShort =
  Duration(milliseconds: 300);

  /// Standard delay
  static const Duration delayMedium =
  Duration(seconds: 1);

  /// Long delay
  static const Duration delayLong =
  Duration(seconds: 2);
}