import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeHeroBanner extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onExplore;

  const HomeHeroBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onExplore,
  });

  @override
  State<HomeHeroBanner> createState() =>
      _HomeHeroBannerState();
}

class _HomeHeroBannerState
    extends State<HomeHeroBanner> {
  bool isExpanded = false;

  void toggleBanner() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 450,
      ),
      curve: Curves.easeInOut,
      height: isExpanded ? 300 : 190,
      decoration: BoxDecoration(
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.banner,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.card,
        child: Stack(
          children: [
            /// BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            /// DARK OVERLAY
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin:
                    Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black
                          .withValues(
                        alpha: 0.70,
                      ),
                      AppColors.black
                          .withValues(
                        alpha: 0.10,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// TOGGLE BUTTON
            Positioned(
              top: AppSpacing.md,
              right: AppSpacing.md,
              child: GestureDetector(
                onTap: toggleBanner,
                child: AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 250,
                  ),
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal:
                    AppSpacing.md,
                    vertical:
                    AppSpacing.xs,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    AppColors.primaryGreen,
                    borderRadius:
                    BorderRadius.circular(
                      50,
                    ),
                    boxShadow:
                    AppShadows.cardSoft,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isExpanded
                            ? Icons
                            .keyboard_arrow_up_rounded
                            : Icons
                            .keyboard_arrow_down_rounded,
                        color:
                        AppColors.white,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        isExpanded
                            ? "Less"
                            : "More",
                        style:
                        AppTextStyles
                            .caption(
                          color:
                          AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal:
                  AppSpacing.lg,
                  vertical:
                  AppSpacing.lg,
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    /// TITLE CENTERED
                    Text(
                      widget.title,
                      textAlign:
                      TextAlign.center,
                      maxLines: 2,
                      overflow:
                      TextOverflow
                          .ellipsis,
                      style:
                      AppTextStyles
                          .titleLarge(
                        color:
                        AppColors.white,
                      ),
                    ),

                    const SizedBox(
                      height:
                      AppSpacing.sm,
                    ),

                    /// SUBTITLE ONLY WHEN EXPANDED
                    if (isExpanded)
                      Text(
                        widget.subtitle,
                        textAlign:
                        TextAlign.center,
                        style:
                        AppTextStyles
                            .bodySmall(
                          color: AppColors
                              .white
                              .withValues(
                            alpha: 0.90,
                          ),
                        ),
                      ),

                    const SizedBox(
                      height:
                      AppSpacing.md,
                    ),

                    /// BUTTON SMALLER + MORE ROUNDED
                    SizedBox(
                      width: 155,
                      height: 42,
                      child: ElevatedButton(
                        onPressed:
                        widget.onExplore,
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          AppColors.white,
                          foregroundColor:
                          AppColors
                              .primaryGreen,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: Text(
                          "View Family",
                          style:
                          AppTextStyles
                              .bodySmall(
                            color: AppColors
                                .primaryGreen,
                            weight:
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}