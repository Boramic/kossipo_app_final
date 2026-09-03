import 'package:flutter/foundation.dart';

import 'family_event.dart';

@immutable
class EventDraft {
  final String title;
  final String description;
  final String location;

  final FamilyEventType type;

  final DateTime? startDate;
  final DateTime? endDate;

  final bool isAllDay;

  const EventDraft({
    this.title = '',
    this.description = '',
    this.location = '',
    this.type = FamilyEventType.other,
    this.startDate,
    this.endDate,
    this.isAllDay = false,
  });

  EventDraft copyWith({
    String? title,
    String? description,
    String? location,
    FamilyEventType? type,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDay,
  }) {
    return EventDraft(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }

  // ------------------------------------------------
  // FIELD HELPERS
  // ------------------------------------------------

  bool get hasTitle =>
      title.trim().isNotEmpty;

  bool get hasDescription =>
      description.trim().isNotEmpty;

  bool get hasLocation =>
      location.trim().isNotEmpty;

  bool get hasStartDate =>
      startDate != null;

  bool get hasEndDate =>
      endDate != null;

  bool get hasValidDateRange {
    if (startDate == null ||
        endDate == null) {
      return false;
    }

    return endDate!.isAfter(startDate!);
  }

  // ------------------------------------------------
  // FORM VALIDATION
  // ------------------------------------------------

  bool get isValid {
    return hasTitle &&
        hasDescription &&
        hasStartDate &&
        hasEndDate &&
        hasValidDateRange;
  }

  // ------------------------------------------------
  // EMPTY STATE
  // ------------------------------------------------

  bool get isEmpty {
    return title.isEmpty &&
        description.isEmpty &&
        location.isEmpty &&
        startDate == null &&
        endDate == null;
  }

  // ------------------------------------------------
  // READY FOR SUBMIT
  // ------------------------------------------------

  bool get canSubmit => isValid;

  // ------------------------------------------------
  // UTILITIES
  // ------------------------------------------------

  Duration? get duration {
    if (startDate == null ||
        endDate == null) {
      return null;
    }

    return endDate!.difference(
      startDate!,
    );
  }

  EventDraft clear() {
    return const EventDraft();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is EventDraft &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.type == type &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isAllDay == isAllDay;
  }

  @override
  int get hashCode {
    return Object.hash(
      title,
      description,
      location,
      type,
      startDate,
      endDate,
      isAllDay,
    );
  }

  @override
  String toString() {
    return '''
EventDraft(
  title: $title,
  type: $type,
  location: $location,
  startDate: $startDate,
  endDate: $endDate,
  isAllDay: $isAllDay
)
''';
  }
}