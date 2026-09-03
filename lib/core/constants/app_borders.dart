import 'package:flutter/material.dart';
import 'app_colors.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP BORDERS
/// =======================================================

abstract final class AppBorders {
  AppBorders._();

  //========================================================
  // 🧩 LIGHT
  //========================================================

  static const double light = 0.8;
  static const double input = 1.0;

  //========================================================
  // 🧱 STANDARD
  //========================================================

  static const double normal = 1.5;
  static const double medium = 2.0;

  //========================================================
  // 🔥 EMPHASIS
  //========================================================

  static const double focus = 2.5;
  static const double strong = 3.0;

  //========================================================
  // 🧱 BORDER STYLES (CLEAN + CONSISTENT)
  //========================================================

  static Border inputBorder = Border.all(
    width: input,
    color: AppColors.border,
  );

  static Border inputFocusedBorder = Border.all(
    width: focus,
    color: AppColors.primaryGreen,
  );

  static Border cardBorder = Border.all(
    width: normal,
    color: AppColors.divider,
  );

  static Border buttonBorder = Border.all(
    width: normal,
    color: AppColors.primaryGreen,
  );
}