/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP SIZES
/// =======================================================
///
/// Toutes les tailles réutilisables de l'application
/// doivent être définies ici.
///
/// ❌ Mauvais
///
/// height: 54
/// width: 42
/// size: 24
///
/// ✅ Bon
///
/// height: AppSizes.buttonHeight
///
/// =======================================================

abstract final class AppSizes {
  AppSizes._();

  //========================================================
  // BUTTONS
  //========================================================

  static const double buttonHeight = 54;
  static const double buttonMinWidth = 140;
  static const double buttonIconSize = 22;

  //========================================================
  // INPUTS
  //========================================================

  static const double inputHeight = 56;
  static const double inputIconSize = 22;

  //========================================================
  // ICONS
  //========================================================

  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;

  //========================================================
  // AVATARS
  //========================================================

  static const double avatarXs = 28;
  static const double avatarSm = 40;
  static const double avatarMd = 56;
  static const double avatarLg = 72;
  static const double avatarXl = 96;

  //========================================================
  // LOGOS
  //========================================================

  static const double logoSm = 60;
  static const double logoMd = 100;
  static const double logoLg = 160;

  //========================================================
  // BADGES
  //========================================================

  static const double badgeSize = 20;
  static const double notificationDot = 10;

  //========================================================
  // CARDS
  //========================================================

  static const double cardMinHeight = 120;
  static const double storyCardHeight = 180;
  static const double bannerHeight = 180;

  //========================================================
  // APP BAR
  //========================================================

  static const double appBarHeight = 64;

  //========================================================
  // BOTTOM NAVIGATION
  //========================================================

  static const double bottomNavHeight = 72;

  //========================================================
  // DIVIDERS
  //========================================================

  static const double dividerThickness = 1;

  //========================================================
  // LOADER
  //========================================================

  static const double loaderSize = 20;
  static const double loaderStrokeWidth = 2;

  //========================================================
  // IMAGES
  //========================================================

  static const double onboardingHeaderHeight = 320;
  static const double onboardingImageSize = 260;
}