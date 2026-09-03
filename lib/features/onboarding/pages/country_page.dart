import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../../../app/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../auth/services/auth_service.dart';

import '../../../shared/buttons/primary_button.dart';
import '../../../shared/layouts/onboarding_step_layout.dart';
import '../../../shared/widgets/onboarding_progress.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() =>
      _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Country? selectedCountry;
  bool isLoading = false;

  Future<void> _saveCountry() async {
    if (selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select your country",
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
          "country": {
            "name": selectedCountry!.name,
            "code":
            selectedCountry!.countryCode,
            "flag":
            selectedCountry!.flagEmoji,
          },
        },
      );

      if (!mounted) return;

      Navigator.pushNamed(
        context,
        AppRoutes.village,
        arguments: {
          "country":
          selectedCountry!.name,
        },
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

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace =
        MediaQuery.of(context).viewInsets.bottom;

    return OnboardingStepLayout(
      image: 'assets/images/country.jpeg',
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
              "Country",
              style: AppTextStyles.h2(),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              "Select your family's country of origin.",
              style:
              AppTextStyles.bodySmall(),
            ),

            const SizedBox(
              height: AppSpacing.sectionGap,
            ),

            GestureDetector(
              onTap: _pickCountry,
              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical:
                  AppSpacing.mdPlus,
                ),
                decoration: BoxDecoration(
                  color:
                  AppColors.secondaryGreen,
                  borderRadius:
                  BorderRadius.circular(
                    16,
                  ),
                ),
                child: Row(
                  children: [
                    if (selectedCountry != null)
                      Text(
                        selectedCountry!
                            .flagEmoji,
                        style:
                        const TextStyle(
                          fontSize: 26,
                        ),
                      ),

                    if (selectedCountry != null)
                      const SizedBox(
                        width:
                        AppSpacing.md,
                      ),

                    Expanded(
                      child: Text(
                        selectedCountry
                            ?.name ??
                            "Choose your country",
                        style:
                        AppTextStyles.body(),
                      ),
                    ),

                    const Icon(
                      Icons
                          .keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const OnboardingProgress(
                  currentStep: 1,
                ),

                SizedBox(
                  width: 160,
                  child: PrimaryButton(
                    text: "Next",
                    isLoading: isLoading,
                    onPressed: _saveCountry,
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
    );
  }
}