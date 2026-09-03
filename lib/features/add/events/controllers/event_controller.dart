import 'package:flutter/foundation.dart';

import '../models/event_draft.dart';
import '../models/family_event.dart';

class EventController extends ChangeNotifier {
  EventDraft _draft = const EventDraft();

  EventDraft get draft => _draft;

  // --------------------------------------------------
  // TITLE
  // --------------------------------------------------

  void updateTitle(String value) {
    final trimmed = value.trimLeft();

    if (_draft.title == trimmed) {
      return;
    }

    _draft = _draft.copyWith(
      title: trimmed,
    );

    notifyListeners();
  }

  // --------------------------------------------------
  // DESCRIPTION
  // --------------------------------------------------

  void updateDescription(String value) {
    if (_draft.description == value) {
      return;
    }

    _draft = _draft.copyWith(
      description: value,
    );

    notifyListeners();
  }

  // --------------------------------------------------
  // LOCATION
  // --------------------------------------------------

  void updateLocation(String value) {
    if (_draft.location == value) {
      return;
    }

    _draft = _draft.copyWith(
      location: value,
    );

    notifyListeners();
  }

  // --------------------------------------------------
  // START DATE
  // --------------------------------------------------

  void updateStartDate(
      DateTime date,
      ) {
    DateTime? adjustedEndDate =
        _draft.endDate;

    if (adjustedEndDate != null &&
        adjustedEndDate.isBefore(date)) {
      adjustedEndDate = date.add(
        const Duration(hours: 1),
      );
    }

    _draft = _draft.copyWith(
      startDate: date,
      endDate: adjustedEndDate,
    );

    notifyListeners();
  }
  FamilyEventType get type {
    return _draft.type;
  }

  // --------------------------------------------------
  // END DATE
  // --------------------------------------------------

  void updateEndDate(
      DateTime date,
      ) {
    _draft = _draft.copyWith(
      endDate: date,
    );

    notifyListeners();
  }
  // --------------------------------------------------
// EVENT TYPE
// --------------------------------------------------

  void updateType(
      FamilyEventType type,
      ) {
    if (_draft.type == type) {
      return;
    }

    _draft = _draft.copyWith(
      type: type,
    );

    notifyListeners();
  }

  // --------------------------------------------------
  // ALL DAY
  // --------------------------------------------------

  void toggleAllDay(bool value) {
    if (_draft.isAllDay == value) {
      return;
    }

    _draft = _draft.copyWith(
      isAllDay: value,
    );

    notifyListeners();
  }

  // --------------------------------------------------
  // REPLACE DRAFT
  // --------------------------------------------------

  void loadDraft(
      EventDraft draft,
      ) {
    _draft = draft;

    notifyListeners();
  }

  // --------------------------------------------------
  // RESET
  // --------------------------------------------------

  void clear() {
    _draft = const EventDraft();

    notifyListeners();
  }

  // --------------------------------------------------
  // VALIDATION
  // --------------------------------------------------

  bool get canSubmit {
    return _draft.isValid;
  }

  bool get hasTitle {
    return _draft.hasTitle;
  }

  bool get hasDescription {
    return _draft.hasDescription;
  }

  bool get hasLocation {
    return _draft.hasLocation;
  }

  bool get hasStartDate {
    return _draft.hasStartDate;
  }

  bool get hasEndDate {
    return _draft.hasEndDate;
  }

  bool get isAllDay {
    return _draft.isAllDay;
  }

  bool get isValid {
    return _draft.isValid;
  }

  Duration? get duration {
    return _draft.duration;
  }

  // --------------------------------------------------
  // VALIDATION ERRORS
  // --------------------------------------------------

  String? get titleError {
    if (_draft.title.isEmpty) {
      return 'Title is required';
    }

    return null;
  }

  String? get descriptionError {
    if (_draft.description.isEmpty) {
      return 'Description is required';
    }

    return null;
  }

  String? get dateError {
    if (!_draft.hasStartDate) {
      return 'Start date is required';
    }

    if (!_draft.hasEndDate) {
      return 'End date is required';
    }

    if (!_draft.hasValidDateRange) {
      return 'End date must be after start date';
    }

    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}