import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../shared/buttons/primary_button.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/services/family_service.dart';

class MoveToFamilyPage extends StatefulWidget {
  const MoveToFamilyPage({super.key});

  @override
  State<MoveToFamilyPage> createState() => _MoveToFamilyPageState();
}

class _MoveToFamilyPageState extends State<MoveToFamilyPage> {
  final TextEditingController familyCodeController =
  TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    familyCodeController.dispose();
    super.dispose();
  }

  Future<void> _joinFamily() async {
    final code = familyCodeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a family code"),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final success = await FamilyService.joinFamily(code);

      if (!mounted) return;

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Family not found"),
          ),
        );
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
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

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: "Enter family code",
      filled: true,
      fillColor: AppColors.white.withValues(alpha: 0.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
    );
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
                  minHeight: MediaQuery.of(context).size.height - 40,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () => Navigator.pop(context),
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

                      const SizedBox(height: 40),

                      Center(
                        child: Image.asset(
                          "assets/images/logo white1.png",
                          height: 90,
                        ),
                      ),

                      const SizedBox(height: 50),

                      Text(
                        "Join your family",
                        style: AppTextStyles.h1(
                          color: AppColors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Use your family invitation code to reconnect and continue building your legacy together.",
                        style: AppTextStyles.body(
                          color: AppColors.white.withValues(alpha: 0.75),
                        ),
                      ),

                      const SizedBox(height: 40),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 18,
                            sigmaY: 18,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: familyCodeController,
                                  style: AppTextStyles.body(
                                    color: AppColors.white,
                                  ),
                                  decoration: _inputDecoration(),
                                ),

                                const SizedBox(height: 24),

                                PrimaryButton(
                                  text: "Join Family",
                                  isLoading: isLoading,
                                  onPressed: _joinFamily,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: Text(
                          "Family is where your story begins.",
                          style: AppTextStyles.caption(
                            color: AppColors.white.withValues(alpha: 0.55),
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