import 'package:flutter/foundation.dart';

import '../models/story_draft.dart';

class StoryController extends ChangeNotifier {
  StoryController()
      : _draft = StoryDraft.empty();

  StoryDraft _draft;

  bool _saving = false;

  StoryDraft get draft => _draft;

  bool get saving => _saving;

  bool get canSave {
    return !_saving && _draft.isValid;
  }

  // ---------------------------------------------------------------------------
  // TITLE
  // ---------------------------------------------------------------------------

  void setTitle(String value) {
    _draft = _draft.copyWith(
      title: value.trim(),
    );

    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // CONTENT
  // ---------------------------------------------------------------------------

  void setContent(String value) {
    _draft = _draft.copyWith(
      content: value.trim(),
    );

    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // TYPE
  // ---------------------------------------------------------------------------

  void setIsQuote(bool value) {
    _draft = _draft.copyWith(
      isQuote: value,
    );

    notifyListeners();
  }

  void toggleQuoteMode() {
    _draft = _draft.copyWith(
      isQuote: !_draft.isQuote,
    );

    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // SAVE
  // ---------------------------------------------------------------------------

  Future<void> save(
      Future<void> Function(
          StoryDraft draft,
          )
      repository,
      ) async {
    if (!_draft.isValid) {
      return;
    }

    _saving = true;
    notifyListeners();

    try {
      await repository(_draft);
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // RESET
  // ---------------------------------------------------------------------------

  void reset() {
    _draft = StoryDraft.empty();

    notifyListeners();
  }
}