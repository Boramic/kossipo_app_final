import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/routes/app_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../features/auth/services/auth_service.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/layouts/onboarding_step_layout.dart';
import '../../../shared/widgets/onboarding_progress.dart';

import '../data/villages_data.dart';

class VillagePage extends StatefulWidget {
  const VillagePage({super.key});

  @override
  State<VillagePage> createState() =>
      _VillagePageState();
}

class _VillagePageState extends State<VillagePage> {
  String? selectedVillage;
  bool isLoading = false;

  List<String> villages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
    ModalRoute.of(context)?.settings.arguments
    as Map<String, dynamic>?;

    final country =
        args?["country"] ?? "Cameroon";

    villages =
        VillagesData.villagesByCountry[country] ??
            [];
  }

  Future<void> _saveVillage() async {
    if (selectedVillage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please select your village",
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = AuthService.currentUser;

      if (user == null) {
        throw Exception(
          "User not authenticated",
        );
      }

      await AuthService.updateUserData(
        uid: user.uid,
        data: {
          "village": selectedVillage,
          "profileCompleted": true,
        },
      );

      if (!mounted) return;

      AppRouter.clearAndPush(
        context,
        AppRoutes.home,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
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

  @override
  Widget build(BuildContext context) {
    final keyboardSpace =
        MediaQuery.of(context).viewInsets.bottom;

    return OnboardingStepLayout(
      image: 'assets/images/village.jpeg',
      child: AnimatedPadding(
        duration:
        const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          left: AppSpacing.pageHorizontal,
          right: AppSpacing.pageHorizontal,
          bottom: keyboardSpace + 24,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Text(
              "Village",
              style: AppTextStyles.h2(),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              "Choose your family's village of origin.",
              style:
              AppTextStyles.bodySmall(),
            ),

            const SizedBox(
              height: AppSpacing.sectionGap,
            ),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color:
                AppColors.secondaryGreen,
                borderRadius:
                BorderRadius.circular(16),
              ),
              child:
              DropdownButtonFormField<String>(
                value: selectedVillage,
                decoration:
                const InputDecoration(
                  border: InputBorder.none,
                ),
                hint: const Text(
                  "Select village",
                ),
                items: villages.map((village) {
                  return DropdownMenuItem(
                    value: village,
                    child: Text(village),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedVillage = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const OnboardingProgress(
                  currentStep: 2,
                ),

                SizedBox(
                  width: 160,
                  child: PrimaryButton(
                    text: "Finish",
                    isLoading: isLoading,
                    onPressed: _saveVillage,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.pageBottom,
            ),
          ],
        ),
      ),
    );
  }
}