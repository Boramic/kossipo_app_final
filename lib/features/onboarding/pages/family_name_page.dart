import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/inputs/app_text_field.dart';
import '../../../shared/layouts/onboarding_step_layout.dart';
import '../../../shared/widgets/onboarding_progress.dart';

import '../../../data/services/family_service.dart';

class FamilyNamePage extends StatefulWidget {
  const FamilyNamePage({super.key});

  @override
  State<FamilyNamePage> createState() =>
      _FamilyNamePageState();
}

class _FamilyNamePageState
    extends State<FamilyNamePage> {
  late final TextEditingController familyController;
  late final TextEditingController familyCodeController;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    familyController = TextEditingController();
    familyCodeController = TextEditingController();
  }

  @override
  void dispose() {
    familyController.dispose();
    familyCodeController.dispose();
    super.dispose();
  }

  Future<void> _nextStep() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final familyName =
    familyController.text.trim();

    final familyCode =
    familyCodeController.text
        .trim()
        .toUpperCase();

    try {
      setState(() {
        isLoading = true;
      });

      await FamilyService.createFamily(
        familyName: familyName,
        familyCode: familyCode,
      );

      if (!mounted) return;

      AppRouter.push(
        context,
        AppRoutes.country,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Failed to create family: $e",
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
    return OnboardingStepLayout(
      image: 'assets/images/family3.jpeg',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                Text(
                  "Family Setup",
                  style:
                  AppTextStyles.titleLarge(),
                ),

                const SizedBox(height: 8),

                Text(
                  "Create your family identity and define a unique access code for your members.",
                  style:
                  AppTextStyles.bodySmall(),
                ),

                const SizedBox(height: 30),

                Text(
                  "Family Name",
                  style:
                  AppTextStyles.bodySmall(
                    weight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                AppTextField(
                  controller: familyController,
                  hintText:
                  "ex: Tchente Family",
                ),

                const SizedBox(height: 20),

                Text(
                  "Family Code",
                  style:
                  AppTextStyles.bodySmall(
                    weight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                AppTextField(
                  controller:
                  familyCodeController,
                  hintText:
                  "ex: TCHENTE001",
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    const OnboardingProgress(
                      currentStep: 0,
                    ),

                    SizedBox(
                      width: 140,
                      child: PrimaryButton(
                        text: "Next",
                        isLoading: isLoading,
                        onPressed: _nextStep,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height:
                  AppSpacing.pageBottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}