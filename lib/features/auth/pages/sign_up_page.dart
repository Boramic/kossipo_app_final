import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/routes/app_router.dart';
import '../../../data/services/auth_service.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/inputs/app_email_field.dart';
import '../../../shared/inputs/app_password_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() =>
      _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with TickerProviderStateMixin {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool agreeTerms = false;
  bool isLoading = false;

  late final AnimationController _headerController;
  late final AnimationController _formController;

  late final Animation<double> _logoAnimation;
  late final Animation<Offset> _formSlide;

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

    _formSlide = Tween<Offset>(
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

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future<void> _signUp() async {
    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please accept terms and conditions",
          ),
        ),
      );
      return;
    }

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required"),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await AuthService.signUp(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      AppRouter.clearAndPush(
        context,
        AppRoutes.familyGateway,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";

      if (e.code == "email-already-in-use") {
        message = "This email is already registered";
      } else if (e.code == "weak-password") {
        message = "Password is too weak";
      } else if (e.code == "invalid-email") {
        message = "Invalid email address";
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

  Widget _buildNameField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: "Full name",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
        ),
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
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            AppSpacing.pageHorizontal,
            24,
            AppSpacing.pageHorizontal,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SlideTransition(
            position: _formSlide,
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
                    "Create your family account",
                    style: AppTextStyles.caption(
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Create your account",
                  style: AppTextStyles.h2(
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Start preserving your family memories, roots and legacy for future generations.",
                  style: AppTextStyles.body(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 28),

                _buildNameField(),

                const SizedBox(height: 16),

                EmailField(
                  controller: emailController,
                ),

                const SizedBox(height: 16),

                PasswordField(
                  controller: passwordController,
                ),

                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: agreeTerms,
                      activeColor:
                      AppColors.primaryGreen,
                      onChanged: (value) {
                        setState(() {
                          agreeTerms =
                              value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I accept terms & privacy policy",
                        style:
                        AppTextStyles.caption(
                          color:
                          AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                PrimaryButton(
                  text: "Create Account",
                  isLoading: isLoading,
                  onPressed: _signUp,
                ),

                const SizedBox(height: 28),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      AppRouter.replace(
                        context,
                        AppRoutes.login,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text:
                        "Already have an account? ",
                        style:
                        AppTextStyles.bodySmall(
                          color: AppColors
                              .textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
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