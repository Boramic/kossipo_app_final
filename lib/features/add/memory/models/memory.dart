import 'package:flutter/foundation.dart';

import 'memory_type.dart';

@immutable
class Memory {
  final String id;

  final String familyId;

  final MemoryType type;

  final String title;
  final String description;
  final String location;

  final String mediaUrl;

  final DateTime capturedDate;

  final String? primaryPersonId;

  final List<String> taggedMembers;

  final String createdBy;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Memory({
    required this.id,
    required this.familyId,
    required this.type,
    required this.title,
    required this.description,
    required this.location,
    required this.mediaUrl,
    required this.capturedDate,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.primaryPersonId,
    this.taggedMembers = const [],
  });

  Memory copyWith({
    String? id,
    String? familyId,
    MemoryType? type,
    String? title,
    String? description,
    String? location,
    String? mediaUrl,
    DateTime? capturedDate,
    String? primaryPersonId,
    List<String>? taggedMembers,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Memory(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      capturedDate: capturedDate ?? this.capturedDate,
      primaryPersonId:
      primaryPersonId ?? this.primaryPersonId,
      taggedMembers:
      taggedMembers ?? this.taggedMembers,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'type': type.id,
      'title': title,
      'description': description,
      'location': location,
      'mediaUrl': mediaUrl,
      'capturedDate':
      capturedDate.toIso8601String(),
      'primaryPersonId': primaryPersonId,
      'taggedMembers': taggedMembers,
      'createdBy': createdBy,
      'createdAt':
      createdAt.toIso8601String(),
      'updatedAt':
      updatedAt.toIso8601String(),
    };
  }

  factory Memory.fromMap(
      Map<String, dynamic> map,
      ) {
    return Memory(
      id: map['id'] ?? '',
      familyId: map['familyId'] ?? '',
      type: MemoryType.fromString(
        map['type'] ?? 'image',
      ),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      mediaUrl: map['mediaUrl'] ?? '',
      capturedDate: DateTime.parse(
        map['capturedDate'],
      ),
      primaryPersonId:
      map['primaryPersonId'],
      taggedMembers:
      List<String>.from(
        map['taggedMembers'] ?? [],
      ),
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      updatedAt: DateTime.parse(
        map['updatedAt'],
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Memory &&
        other.id == id &&
        other.familyId == familyId &&
        other.type == type &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.mediaUrl == mediaUrl &&
        other.capturedDate == capturedDate &&
        other.primaryPersonId ==
            primaryPersonId &&
        listEquals(
          other.taggedMembers,
          taggedMembers,
        ) &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      familyId,
      type,
      title,
      description,
      location,
      mediaUrl,
      capturedDate,
      primaryPersonId,
      Object.hashAll(taggedMembers),
      createdBy,
      createdAt,
      updatedAt,
    );
  }
}