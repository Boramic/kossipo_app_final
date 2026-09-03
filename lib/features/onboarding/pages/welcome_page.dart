import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../../../shared/buttons/primary_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {

  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _buttonController;

  late final Animation<double> _logoAnimation;
  late final Animation<Offset> _textAnimation;
  late final Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    );

    _startSequence();
  }

  void _startSequence() async {
    await _logoController.forward();
    if (!mounted) return;

    await _textController.forward();
    if (!mounted) return;

    await _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Color _overlay(double opacity) {
    return AppColors.primary.withOpacity(opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome back.png',
              fit: BoxFit.cover,
            ),
          ),

          /// GRADIENT OVERLAY (SAFE VERSION)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.4, 0.75, 1],
                  colors: [
                    _overlay(0.95),
                    _overlay(0.8),
                    _overlay(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          /// BLUR LAYER
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.transparent),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: Column(
                children: [

                  const SizedBox(height: 80),

                  /// LOGO
                  FadeTransition(
                    opacity: _logoAnimation,
                    child: Image.asset(
                      'assets/images/logo white1.png',
                      height: 150,
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// TEXT
                  SlideTransition(
                    position: _textAnimation,
                    child: Column(
                      children: [
                        Text(
                          "Your family has a story.\nDon't let it disappear.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2(
                            color: AppColors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Save, share and pass on your family memories across generations.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.white.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// BUTTON
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: "Create my family space",
                        onPressed: () {
                          AppRouter.push(
                            context,
                            AppRoutes.signup,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      AppRouter.push(
                        context,
                        AppRoutes.login,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: AppTextStyles.bodySmall(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: AppTextStyles.bodySmall(
                              color: AppColors.white,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}