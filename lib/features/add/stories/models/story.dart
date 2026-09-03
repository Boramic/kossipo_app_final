import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Story {
  final String id;

  final String familyId;

  final String title;

  final String content;

  final String authorId;

  /// true = quote
  /// false = story
  final bool isQuote;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Story({
    required this.id,
    required this.familyId,
    required this.title,
    required this.content,
    required this.authorId,
    required this.isQuote,
    required this.createdAt,
    required this.updatedAt,
  });

  Story copyWith({
    String? id,
    String? familyId,
    String? title,
    String? content,
    String? authorId,
    bool? isQuote,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Story(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      isQuote: isQuote ?? this.isQuote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'title': title,
      'content': content,
      'authorId': authorId,
      'isQuote': isQuote,
      'createdAt': Timestamp.fromDate(
        createdAt,
      ),
      'updatedAt': Timestamp.fromDate(
        updatedAt,
      ),
    };
  }

  factory Story.fromMap(
      Map<String, dynamic> map,
      ) {
    return Story(
      id: map['id'] as String? ?? '',
      familyId:
      map['familyId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      content:
      map['content'] as String? ?? '',
      authorId:
      map['authorId'] as String? ?? '',
      isQuote:
      map['isQuote'] as bool? ?? false,
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

  bool get hasTitle =>
      title.trim().isNotEmpty;

  bool get hasContent =>
      content.trim().isNotEmpty;

  bool get isValid =>
      hasTitle && hasContent;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Story &&
        other.id == id &&
        other.familyId == familyId &&
        other.title == title &&
        other.content == content &&
        other.authorId == authorId &&
        other.isQuote == isQuote &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      familyId,
      title,
      content,
      authorId,
      isQuote,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return '''
Story(
  id: $id,
  familyId: $familyId,
  title: $title,
  authorId: $authorId,
  isQuote: $isQuote,
  createdAt: $createdAt,
  updatedAt: $updatedAt
)
''';
  }
}