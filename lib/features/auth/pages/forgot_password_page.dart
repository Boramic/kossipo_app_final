import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../data/services/auth_service.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/inputs/app_email_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetCode() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email."),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await AuthService.forgotPassword(
        email: email,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password reset email sent successfully.",
          ),
        ),
      );

      AppRouter.push(
        context,
        AppRoutes.otp,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Failed to send reset email";

      if (e.code == "user-not-found") {
        message = "No account found with this email";
      } else if (e.code == "invalid-email") {
        message = "Invalid email format";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background,
                    AppColors.primary,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 80,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => AppRouter.back(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/logo_white1.png',
                          height: 70,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.h1(
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your email and we’ll send you a password reset link.",
                          style: AppTextStyles.body(
                            color: AppColors.white.withValues(
                              alpha: 0.72,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 42),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 18,
                            sigmaY: 18,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(
                                alpha: 0.04,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: AppColors.white.withValues(
                                  alpha: 0.08,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                EmailField(
                                  controller: emailController,
                                ),

                                const SizedBox(height: 24),

                                PrimaryButton(
                                  text: "Send Reset Link",
                                  isLoading: isLoading,
                                  onPressed: _sendResetCode,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          AppRouter.back(context);
                        },
                        child: Text(
                          "Back to Sign In",
                          style: AppTextStyles.bodySmall(
                            color: AppColors.white,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}