import 'package:flutter/foundation.dart';

import 'memory_type.dart';

@immutable
class MemoryDraft {
  final MemoryType type;

  final String title;
  final String description;
  final String location;

  final DateTime capturedDate;

  /// Local file path before upload.
  final String? mediaPath;

  /// Main person represented in the memory.
  final String? primaryPersonId;

  /// Tagged family members.
  final List<String> taggedMembers;

  const MemoryDraft({
    required this.type,
    required this.capturedDate,
    this.title = '',
    this.description = '',
    this.location = '',
    this.mediaPath,
    this.primaryPersonId,
    this.taggedMembers = const [],
  });

  factory MemoryDraft.empty(
      MemoryType type,
      ) {
    return MemoryDraft(
      type: type,
      capturedDate: DateTime.now(),
    );
  }

  MemoryDraft copyWith({
    MemoryType? type,
    String? title,
    String? description,
    String? location,
    DateTime? capturedDate,
    String? mediaPath,
    String? primaryPersonId,
    List<String>? taggedMembers,
  }) {
    return MemoryDraft(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      capturedDate: capturedDate ?? this.capturedDate,
      mediaPath: mediaPath ?? this.mediaPath,
      primaryPersonId:
      primaryPersonId ?? this.primaryPersonId,
      taggedMembers: List.unmodifiable(
        taggedMembers ?? this.taggedMembers,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MEDIA
  // ---------------------------------------------------------------------------

  bool get hasMedia {
    return mediaPath != null &&
        mediaPath!.trim().isNotEmpty;
  }

  // ---------------------------------------------------------------------------
  // CONTENT
  // ---------------------------------------------------------------------------

  bool get hasTitle {
    return title.trim().isNotEmpty;
  }

  bool get hasDescription {
    return description.trim().isNotEmpty;
  }

  bool get hasLocation {
    return location.trim().isNotEmpty;
  }

  bool get hasPrimaryPerson {
    return primaryPersonId != null &&
        primaryPersonId!.trim().isNotEmpty;
  }

  bool get hasTaggedMembers {
    return taggedMembers.isNotEmpty;
  }

  // ---------------------------------------------------------------------------
  // VALIDATION
  // ---------------------------------------------------------------------------

  bool get isValid {
    return hasTitle &&
        hasDescription &&
        hasMedia;
  }

  // ---------------------------------------------------------------------------
  // UTILITIES
  // ---------------------------------------------------------------------------

  int get taggedMembersCount {
    return taggedMembers.length;
  }

  // ---------------------------------------------------------------------------
  // EQUALITY
  // ---------------------------------------------------------------------------

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is MemoryDraft &&
        other.type == type &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.capturedDate == capturedDate &&
        other.mediaPath == mediaPath &&
        other.primaryPersonId ==
            primaryPersonId &&
        listEquals(
          other.taggedMembers,
          taggedMembers,
        );
  }

  @override
  int get hashCode {
    return Object.hash(
      type,
      title,
      description,
      location,
      capturedDate,
      mediaPath,
      primaryPersonId,
      Object.hashAll(taggedMembers),
    );
  }

  @override
  String toString() {
    return '''
MemoryDraft(
  type: $type,
  title: $title,
  description: $description,
  location: $location,
  capturedDate: $capturedDate,
  mediaPath: $mediaPath,
  primaryPersonId: $primaryPersonId,
  taggedMembers: $taggedMembers
)
''';
  }
}