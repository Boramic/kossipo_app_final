import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/buttons/primary_button.dart';

class FamilyGatewayPage extends StatefulWidget {
  const FamilyGatewayPage({super.key});

  @override
  State<FamilyGatewayPage> createState() =>
      _FamilyGatewayPageState();
}

class _FamilyGatewayPageState
    extends State<FamilyGatewayPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Color _overlay(double opacity) {
    return AppColors.primaryGreen.withValues(
      alpha: opacity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/family4.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    _overlay(.95),
                    _overlay(.75),
                    _overlay(.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .03,
                              ),

                              Center(
                                child: Image.asset(
                                  'assets/images/logo white1.png',
                                  height: 65,
                                ),
                              ),

                              SizedBox(
                                height: height * .04,
                              ),

                              _buildBadge(),

                              SizedBox(
                                height: height * .03,
                              ),

                              Text(
                                "Keep your family\nstory alive.",
                                style: AppTextStyles.h1(
                                  color: AppColors.white,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Text(
                                "Preserve memories, connect generations and build your family's digital legacy.",
                                style: AppTextStyles.body(
                                  color: AppColors.white
                                      .withValues(alpha: .85),
                                ),
                              ),

                              SizedBox(
                                height: height * .04,
                              ),

                              _buildTrustCard(),

                              const Spacer(),

                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  text: "Join my family",
                                  onPressed: () {
                                    AppRouter.push(
                                      context,
                                      AppRoutes.joinFamily,
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 14),

                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    AppRouter.push(
                                      context,
                                      AppRoutes.familyName,
                                    );
                                  },
                                  child: Text(
                                    "Create a new family space",
                                    style:
                                    AppTextStyles.bodySmall(
                                      color: AppColors.white,
                                      weight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              Center(
                                child: Text(
                                  "Your roots • Your people • Your story",
                                  style:
                                  AppTextStyles.caption(
                                    color: AppColors.white
                                        .withValues(
                                      alpha: .65,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        "Family Legacy",
        style: AppTextStyles.caption(
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildTrustCard() {
    return ClipRRect(
      borderRadius: AppRadius.lg,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: .08),
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: AppColors.white.withValues(alpha: .12),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                AppColors.white.withValues(alpha: .12),
                child: const Icon(
                  Icons.groups_rounded,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  "A secure place for your roots, stories and generations.",
                  style: AppTextStyles.bodySmall(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}