import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';

class JoinFamilyPage extends StatefulWidget {
  const JoinFamilyPage({super.key});

  @override
  State<JoinFamilyPage> createState() =>
      _JoinFamilyPageState();
}

class _JoinFamilyPageState
    extends State<JoinFamilyPage>
    with TickerProviderStateMixin {
  final TextEditingController codeController =
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

  Future<void> _joinFamily() async {
    final code = codeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Family code is required",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    AppRouter.clearAndPush(
      context,
      AppRoutes.home,
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    _formController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
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
                const SizedBox(height: 20),

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
                    "Join your family",
                    style: AppTextStyles.caption(
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Enter family code",
                  style: AppTextStyles.h2(
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Use the family code shared with you to join your family space.",
                  style: AppTextStyles.body(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.card,
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: TextField(
                    controller: codeController,
                    textCapitalization:
                    TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: "Ex: KOS-WAF-2026",
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

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
    );
  }
}