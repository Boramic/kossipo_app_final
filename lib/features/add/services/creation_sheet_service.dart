import 'package:flutter/material.dart';

import '../widgets/creation_bottom_sheet.dart';

class CreationSheetService {
  const CreationSheetService._();

  static Future<T?> open<T>({
    required BuildContext context,

    required String title,
    required String subtitle,
    required IconData icon,

    required Widget child,

    required String quote,

    String primaryButtonText = "Save",
    String secondaryButtonText = "Cancel",

    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,

    bool dismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: dismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return CreationBottomSheet(
          title: title,
          subtitle: subtitle,
          icon: icon,

          quote: quote,

          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,

          onPrimaryPressed: onPrimaryPressed,
          onSecondaryPressed: onSecondaryPressed,

          child: child,
        );
      },
    );
  }

  static void close<T>(
      BuildContext context, [
        T? result,
      ]) {
    if (Navigator.canPop(context)) {
      Navigator.pop<T>(context, result);
    }
  }
}