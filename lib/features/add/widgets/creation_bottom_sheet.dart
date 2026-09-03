import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_elevation.dart';
import '../../../core/constants/app_spacing.dart';

import 'sheet_footer.dart';
import 'sheet_handle.dart';
import 'sheet_header.dart';

class CreationBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  final Widget child;

  final String quote;

  final String primaryButtonText;
  final String? secondaryButtonText;

  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  final bool loading;

  const CreationBottomSheet({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    required this.quote,
    required this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.loading = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final keyboardHeight =
        mediaQuery.viewInsets.bottom;

    final maxHeight =
        mediaQuery.size.height * .90;

    return RepaintBoundary(
      child: AnimatedPadding(
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: keyboardHeight,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
            boxShadow: AppElevation.dialog,
          ),
          child: SafeArea(
            top: false,
            bottom: true,
            child: Column(
              children: [
                const SheetHandle(),

                SheetHeader(
                  icon: icon,
                  title: title,
                  description:
                  subtitle ?? "",
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal:
                      AppSpacing.lg,
                    ),
                    child: child,
                  ),
                ),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal:
                    AppSpacing.lg,
                  ),
                  child: SheetFooter(
                    quote: quote,
                    primaryButtonText:
                    primaryButtonText,
                    secondaryButtonText:
                    secondaryButtonText,
                    onPrimaryPressed:
                    onPrimaryPressed,
                    onSecondaryPressed:
                    onSecondaryPressed,
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<T?> showCreationBottomSheet<T>({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Widget child,

  required String quote,
  required String primaryButtonText,

  String? secondaryButtonText,
  String? subtitle,

  VoidCallback? onPrimaryPressed,
  VoidCallback? onSecondaryPressed,

  bool loading = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return CreationBottomSheet(
        title: title,
        subtitle: subtitle,
        icon: icon,

        quote: quote,
        primaryButtonText:
        primaryButtonText,
        secondaryButtonText:
        secondaryButtonText,

        onPrimaryPressed:
        onPrimaryPressed,
        onSecondaryPressed:
        onSecondaryPressed,

        loading: loading,

        child: child,
      );
    },
  );
}