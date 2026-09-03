import 'package:flutter/foundation.dart';

/// ======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP FORM RESULT
/// ======================================================

@immutable
class AppFormResult<T> {
  final bool success;

  final String? message;

  final T? data;

  final Map<String, String?> errors;

  const AppFormResult({
    required this.success,
    this.message,
    this.data,
    this.errors = const {},
  });

  factory AppFormResult.success({
    T? data,
    String? message,
  }) {
    return AppFormResult(
      success: true,
      data: data,
      message: message,
    );
  }

  factory AppFormResult.failure({
    String? message,
    Map<String, String?> errors = const {},
  }) {
    return AppFormResult(
      success: false,
      message: message,
      errors: errors,
    );
  }
}