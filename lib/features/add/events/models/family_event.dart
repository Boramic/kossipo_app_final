import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum FamilyEventType {
  reunion,
  wedding,
  birthday,
  funeral,
  meeting,
  ceremony,
  other,
}

@immutable
class FamilyEvent {
  /// IDENTIFIERS
  final String id;
  final String familyId;
  final String authorId;
  final FamilyEventType type;

  /// CONTENT
  final String title;
  final String description;
  final String location;

  /// DATE & TIME
  final DateTime startDate;
  final DateTime endDate;

  /// SETTINGS
  final bool isAllDay;

  /// METADATA
  final DateTime createdAt;
  final DateTime updatedAt;

  const FamilyEvent({
    required this.id,
    required this.familyId,
    required this.authorId,
    required this.type,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.isAllDay,
    required this.createdAt,
    required this.updatedAt,
  });

  FamilyEvent copyWith({
    String? id,
    String? familyId,
    String? authorId,
    FamilyEventType? type,
    String? title,
    String? description,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FamilyEvent(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      authorId: authorId ?? this.authorId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDay: isAllDay ?? this.isAllDay,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'authorId': authorId,
      'type': type.name,
      'title': title,
      'description': description,
      'location': location,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isAllDay': isAllDay,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory FamilyEvent.fromMap(
      Map<String, dynamic> map,
      ) {
    return FamilyEvent(
      id: map['id'] as String? ?? '',
      familyId: map['familyId'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      type: FamilyEventType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => FamilyEventType.other,
      ),

      title: map['title'] as String? ?? '',
      description:
      map['description'] as String? ?? '',
      location:
      map['location'] as String? ?? '',
      startDate:
      (map['startDate'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
      endDate:
      (map['endDate'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
      isAllDay:
      map['isAllDay'] as bool? ?? false,
      createdAt:
      (map['createdAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
      updatedAt:
      (map['updatedAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  // ------------------------------------------------
  // BUSINESS HELPERS
  // ------------------------------------------------

  bool get hasTitle =>
      title.trim().isNotEmpty;

  bool get hasDescription =>
      description.trim().isNotEmpty;

  bool get hasLocation =>
      location.trim().isNotEmpty;

  bool get isUpcoming =>
      startDate.isAfter(DateTime.now());

  bool get isOngoing {
    final now = DateTime.now();

    return now.isAfter(startDate) &&
        now.isBefore(endDate);
  }

  bool get isPast =>
      endDate.isBefore(DateTime.now());

  Duration get duration =>
      endDate.difference(startDate);

  bool get isValid =>
      hasTitle &&
          hasDescription &&
          endDate.isAfter(startDate);

  // ------------------------------------------------
  // EQUALITY
  // ------------------------------------------------

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is FamilyEvent &&
        other.id == id &&
        other.familyId == familyId &&
        other.authorId == authorId &&
        other.type == type &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isAllDay == isAllDay &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      familyId,
      authorId,
      type,
      title,
      description,
      location,
      startDate,
      endDate,
      isAllDay,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return '''
FamilyEvent(
  id: $id,
  familyId: $familyId,
  authorId: $authorId,
  type: ${type.name},
  title: $title,
  location: $location,
  startDate: $startDate,
  endDate: $endDate,
  isAllDay: $isAllDay
)
''';
  }
}