import 'package:flutter/foundation.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// APP FORM CONTROLLER
/// =======================================================

class AppFormController extends ChangeNotifier {
  AppFormController();

  //==================================================
  // INTERNAL STATE
  //==================================================

  final Map<String, dynamic> _values = {};

  final Map<String, String?> _errors = {};

  final Set<String> _touched = {};

  final Set<String> _dirty = {};

  bool _isLoading = false;

  bool _submitted = false;

  //==================================================
  // GETTERS
  //==================================================

  bool get isLoading => _isLoading;

  bool get submitted => _submitted;

  Map<String, dynamic> get values =>
      Map.unmodifiable(_values);

  Map<String, String?> get errors =>
      Map.unmodifiable(_errors);

  //==================================================
  // VALUE
  //==================================================

  void setValue(
      String key,
      dynamic value,
      ) {
    _values[key] = value;
    _dirty.add(key);

    notifyListeners();
  }

  T? getValue<T>(String key) {
    return _values[key] as T?;
  }

  bool contains(String key) {
    return _values.containsKey(key);
  }

  //==================================================
  // ERROR
  //==================================================

  void setError(
      String key,
      String? error,
      ) {
    _errors[key] = error;

    notifyListeners();
  }

  String? getError(String key) {
    return _errors[key];
  }

  bool hasError(String key) {
    return _errors[key] != null;
  }

  void clearError(String key) {
    _errors.remove(key);

    notifyListeners();
  }

  void clearErrors() {
    _errors.clear();

    notifyListeners();
  }

  //==================================================
  // TOUCHED
  //==================================================

  void touch(String key) {
    _touched.add(key);

    notifyListeners();
  }

  bool isTouched(String key) {
    return _touched.contains(key);
  }

  //==================================================
  // DIRTY
  //==================================================

  bool isDirty(String key) {
    return _dirty.contains(key);
  }

  //==================================================
  // LOADING
  //==================================================

  void setLoading(bool value) {
    if (_isLoading == value) return;

    _isLoading = value;

    notifyListeners();
  }

  //==================================================
  // SUBMITTED
  //==================================================

  void markSubmitted() {
    _submitted = true;

    notifyListeners();
  }

  void resetSubmitted() {
    _submitted = false;

    notifyListeners();
  }

  //==================================================
  // VALIDATION
  //==================================================

  bool validate(
      Map<String, String? Function()> validators,
      ) {
    bool valid = true;

    _errors.clear();

    validators.forEach((key, validator) {
      final result = validator();

      _errors[key] = result;

      if (result != null) {
        valid = false;
      }
    });

    _submitted = true;

    notifyListeners();

    return valid;
  }

  //==================================================
  // RESET FIELD
  //==================================================

  void clearField(String key) {
    _values.remove(key);
    _errors.remove(key);
    _dirty.remove(key);
    _touched.remove(key);

    notifyListeners();
  }

  //==================================================
  // RESET ALL
  //==================================================

  void reset() {
    _values.clear();

    _errors.clear();

    _dirty.clear();

    _touched.clear();

    _submitted = false;

    _isLoading = false;

    notifyListeners();
  }

  //==================================================
  // SUBMIT ENGINE
  //==================================================

  Future<bool> submit({
    required Map<String, String? Function()> validators,
    required Future<void> Function() action,
  }) async {
    final valid = validate(validators);

    if (!valid) {
      return false;
    }

    try {
      setLoading(true);

      await action();

      return true;
    } finally {
      setLoading(false);
    }
  }
}