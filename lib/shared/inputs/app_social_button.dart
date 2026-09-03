import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Image.asset(
            asset,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}