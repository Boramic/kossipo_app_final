import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/services/auth_service.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/inputs/app_email_field.dart';
import '../../../shared/inputs/app_password_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() =>
      _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with TickerProviderStateMixin {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isLoading = false;

  late final AnimationController _headerController;
  late final AnimationController _formController;

  late final Animation<double> _logoAnimation;
  late final Animation<Offset> _formAnimation;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _logoAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );

    _formAnimation = Tween<Offset>(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _formController,
        curve: Curves.easeOutCubic,
      ),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await _headerController.forward();
    if (!mounted) return;
    await _formController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _formController.dispose();

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Email and password are required",
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await AuthService.signIn(
        email: email,
        password: password,
      );

      if (!mounted) return;

      AppRouter.replace(
        context,
        AppRoutes.home,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == "user-not-found") {
        message = "No user found for this email";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password";
      } else if (e.code == "invalid-email") {
        message = "Invalid email format";
      } else if (e.code == "invalid-credential") {
        message = "Invalid credentials";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _socialButton({
    required String asset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 56,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Image.asset(asset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
          const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            AppSpacing.pageHorizontal,
            24,
            AppSpacing.pageHorizontal,
            MediaQuery.of(context)
                .viewInsets
                .bottom +
                24,
          ),
          child: SlideTransition(
            position: _formAnimation,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                Center(
                  child: FadeTransition(
                    opacity: _logoAnimation,
                    child: Image.asset(
                      'assets/images/logo green.png',
                      height: 85,
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGreen,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    "Welcome back",
                    style: AppTextStyles.caption(
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Sign in to continue",
                  style: AppTextStyles.h2(
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Reconnect with your family memories and continue your legacy journey.",
                  style: AppTextStyles.body(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 28),

                EmailField(
                  controller: emailController,
                ),

                const SizedBox(height: 16),

                PasswordField(
                  controller: passwordController,
                ),

                const SizedBox(height: 8),

                Align(
                  alignment:
                  Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      AppRouter.push(
                        context,
                        AppRoutes.forgotPassword,
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style:
                      AppTextStyles.bodySmall(
                        color: AppColors
                            .primaryGreen,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                PrimaryButton(
                  text: "Sign In",
                  isLoading: isLoading,
                  onPressed: _signIn,
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.border,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        "or continue with",
                        style:
                        AppTextStyles.caption(
                          color:
                          AppColors.textMuted,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.border,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      asset:
                      'assets/images/google.png',
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _socialButton(
                      asset:
                      'assets/images/facebook.png',
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _socialButton(
                      asset:
                      'assets/images/apple.png',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      AppRouter.push(
                        context,
                        AppRoutes.signup,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text:
                        "Don't have an account? ",
                        style:
                        AppTextStyles.bodySmall(
                          color: AppColors
                              .textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style:
                            AppTextStyles.bodySmall(
                              color: AppColors
                                  .primaryGreen,
                              weight:
                              FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}