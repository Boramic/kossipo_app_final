/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// SPACING SCALE (SENIOR UI SYSTEM)
/// =======================================================

abstract class AppSpacing {
  AppSpacing._();

  // ======================================================
  // 📏 BASE SCALE (4pt SYSTEM)
  // ======================================================

  /// 4 - micro spacing (icons, tiny gaps)
  static const double xs = 4;

  /// 8 - small spacing (inside components)
  static const double sm = 8;

  /// 12 - compact spacing (rare use, fine tuning)
  static const double smPlus = 12;

  /// 16 - default spacing (MOST USED)
  static const double md = 16;

  /// 20 - medium-large spacing (sections inside cards)
  static const double mdPlus = 20;

  /// 24 - standard section spacing
  static const double lg = 24;

  /// 32 - large separation (major blocks)
  static const double xl = 32;

  /// 40 - page spacing (big layouts)
  static const double xxl = 40;

  /// 48 - extreme spacing (hero sections / onboarding gaps)
  static const double xxxl = 48;

  // ======================================================
  // 🧱 LAYOUT PRESETS (SENIOR LEVEL ABSTRACTION)
  // ======================================================

  /// Default horizontal padding for all screens
  static const double pageHorizontal = md;

  /// Safe area bottom spacing
  static const double pageBottom = xl;

  /// Spacing between form fields
  static const double formFieldGap = md;

  /// Spacing between sections (title → content)
  static const double sectionGap = lg;

  /// Spacing inside cards
  static const double cardPadding = md;

  /// Spacing inside buttons
  static const double buttonPaddingVertical = md;
  static const double buttonPaddingHorizontal = lg;

  /// Spacing between list items
  static const double listItemGap = smPlus;

  // ======================================================
  // 🧠 ONBOARDING / SPECIAL UI FLOWS
  // ======================================================

  /// Big spacing for onboarding screens
  static const double onboardingTop = 120;

  /// Space between header image and content
  static const double onboardingContentGap = 140;

  /// Bottom navigation spacing
  static const double bottomNavSpace = 24;

  // ======================================================
  // 📱 RESPONSIVE READY (FUTURE PROOF)
  // ======================================================

  /// Compact screens (small phones)
  static const double compact = 12;

  /// Standard screens
  static const double normal = 16;

  /// Large screens (tablet/web)
  static const double comfortable = 24;


}
