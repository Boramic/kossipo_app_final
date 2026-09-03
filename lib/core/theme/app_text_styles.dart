import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// TYPOGRAPHY (Poppins Based System)
/// =======================================================

abstract class AppTextStyles {
  AppTextStyles._();

  // ======================================================
  // 🔥 BASE FONT FAMILY
  // ======================================================

  static const String _fontFamily = 'Poppins';

  // ======================================================
  // 🧠 HERO / BIG TITLES
  // ======================================================

  static TextStyle h1({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle h2({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle h3({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }

  // ======================================================
// 🏷 TITLES
// ======================================================

  static TextStyle titleLarge({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle titleMedium({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle titleSmall({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.3,
    );
  }

  // ======================================================
  // 📄 BODY TEXT
  // ======================================================

  static TextStyle body({
    Color color = AppColors.textPrimary,
    FontWeight weight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: weight,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle bodyMedium({
    Color color = AppColors.textPrimary,
    FontWeight weight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 15,
      fontWeight: weight,
      color: color,
      height: 1.45,
    );
  }

  static TextStyle bodySmall({
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: weight,
      color: color,
      height: 1.4,
    );
  }

  // ======================================================
  // 🧾 CAPTIONS / SMALL TEXT
  // ======================================================

  static TextStyle caption({
    Color color = AppColors.textMuted,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.3,
    );
  }

  // ======================================================
  // 🔘 BUTTON TEXT
  // ======================================================

  static TextStyle button({
    Color color = AppColors.white,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5,
    );
  }

  // ======================================================
  // 🏷 FORM LABELS
  // ======================================================

  static TextStyle label({
    Color color = AppColors.textSecondary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  // ======================================================
  // 🌿 SPECIAL (BRAND / EMPHASIS)
  // ======================================================

  static TextStyle brandTitle({
    Color color = AppColors.primary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 0.3,
    );
  }

  static TextStyle heading({
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
      height: 1.3,
    );
  }
}