import 'package:flutter/foundation.dart';

/// ======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP FORM STATE
/// ======================================================

@immutable
class AppFormState {
  final bool isLoading;

  final bool isSubmitted;

  final Map<String, dynamic> values;

  final Map<String, String?> errors;

  final Set<String> touched;

  final Set<String> dirty;

  const AppFormState({
    this.isLoading = false,
    this.isSubmitted = false,
    this.values = const {},
    this.errors = const {},
    this.touched = const {},
    this.dirty = const {},
  });

  AppFormState copyWith({
    bool? isLoading,
    bool? isSubmitted,
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    Set<String>? touched,
    Set<String>? dirty,
  }) {
    return AppFormState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      values: values ?? this.values,
      errors: errors ?? this.errors,
      touched: touched ?? this.touched,
      dirty: dirty ?? this.dirty,
    );
  }
}