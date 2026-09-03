import 'package:flutter/foundation.dart';

@immutable
class StoryDraft {
  final String title;

  final String content;

  /// true = quote
  /// false = story
  final bool isQuote;

  const StoryDraft({
    this.title = '',
    this.content = '',
    this.isQuote = false,
  });

  factory StoryDraft.empty() {
    return const StoryDraft();
  }

  StoryDraft copyWith({
    String? title,
    String? content,
    bool? isQuote,
  }) {
    return StoryDraft(
      title: title ?? this.title,
      content: content ?? this.content,
      isQuote: isQuote ?? this.isQuote,
    );
  }

  bool get hasTitle {
    return title.trim().isNotEmpty;
  }

  bool get hasContent {
    return content.trim().isNotEmpty;
  }

  bool get isValid {
    return hasTitle && hasContent;
  }

  int get titleLength {
    return title.trim().length;
  }

  int get contentLength {
    return content.trim().length;
  }

  bool get isStory {
    return !isQuote;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is StoryDraft &&
        other.title == title &&
        other.content == content &&
        other.isQuote == isQuote;
  }

  @override
  int get hashCode {
    return Object.hash(
      title,
      content,
      isQuote,
    );
  }

  @override
  String toString() {
    return '''
StoryDraft(
  title: $title,
  isQuote: $isQuote,
  contentLength: $contentLength
)
''';
  }
}