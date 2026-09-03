import 'package:flutter/material.dart';

import '../../services/creation_sheet_service.dart';
import 'memory_composer.dart';

class AddMemorySheet {
  const AddMemorySheet._();

  static Future<void> open(
      BuildContext context,
      ) {
    return CreationSheetService.open(
      context: context,

      title: "Family Memory",

      subtitle:
      "Preserve the moments that future generations will cherish.",

      icon: Icons.favorite_rounded,

      quote:
      "Every memory you save today becomes tomorrow's family treasure.",

      primaryButtonText:
      "Continue",

      secondaryButtonText:
      "Cancel",

      onPrimaryPressed: () {
        debugPrint(
          "continue",
        );
      },

      onSecondaryPressed: () {
        Navigator.pop(context);
      },

      child: const MemoryComposer(),
    );
  }
}