import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final String image;

  const OnboardingHeader({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}