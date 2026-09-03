import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class OnboardingStepLayout extends StatelessWidget {
  final String image;
  final Widget child;

  const OnboardingStepLayout({
    super.key,
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
          const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.only(
                        bottomLeft:
                        Radius.circular(32),
                        bottomRight:
                        Radius.circular(32),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: AppSpacing.lg,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo white1.png',
                        height: 90,
                      ),
                    ),
                  ),
                ],
              ),

              child,
            ],
          ),
        ),
      ),
    );
  }
}