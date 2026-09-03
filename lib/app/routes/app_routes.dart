/// =======================================================
/// KOSSIPO
/// APP ROUTES
///
/// Central registry of every route used in the application.
///
/// Senior Architecture:
/// - Single source of truth
/// - No duplicated route strings
/// - Easy maintenance
/// - Easy refactoring
/// - Firebase/Auth ready
/// - Deep linking ready
/// =======================================================

abstract final class AppRoutes {
AppRoutes._();

// =====================================================
// INITIAL
// =====================================================

static const String splash = "/";

static const String welcome = "/welcome";

// =====================================================
// AUTH
// =====================================================

static const String login = "/login";

static const String signup = "/signup";

static const String otp = "/otp";

static const String forgotPassword = "/forgot-password";

static const String resetPassword = "/reset-password";

static const familyGateway = '/family-gateway';
static const String moveToFamily = '/move-to-family';

static const String familyName = '/family-name';
static const String country = '/country';
static const String village = '/village';

static const String createProfile = "/create-profile";
static const joinFamily = '/join-family';

// =====================================================
// MAIN APPLICATION
// =====================================================

static const String home = "/home";

static const String add = "/add";

static const String family = "/family";

static const String familyTree = "/family-tree";

static const String events = "/events";

static const String gallery = "/gallery";

static const String search = "/search";

static const String notifications = "/notifications";

static const String messages = "/messages";

// =====================================================
// PROFILE
// =====================================================

static const String profile = "/profile";

static const String editProfile = "/profile/edit";

// =====================================================
// SETTINGS
// =====================================================

static const String settings = "/settings";

static const String privacy = "/settings/privacy";

static const String security = "/settings/security";

static const String about = "/settings/about";

static const String terms = "/settings/terms";

// =====================================================
// ADMIN
// =====================================================

static const String admin = "/admin";

// =====================================================
// ERROR
// =====================================================

static const String notFound = "/404";
}
