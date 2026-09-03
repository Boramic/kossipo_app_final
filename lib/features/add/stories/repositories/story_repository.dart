import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/story.dart';
import '../models/story_draft.dart';

class StoryRepository {
  StoryRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
      firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  // ---------------------------------------------------------------------------
  // COLLECTION
  // ---------------------------------------------------------------------------

  CollectionReference<Map<String, dynamic>>
  _storiesCollection(
      String familyId,
      ) {
    return _firestore
        .collection('families')
        .doc(familyId)
        .collection('stories');
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Story> createStory({
    required String familyId,
    required String authorId,
    required StoryDraft draft,
  }) async {
    if (!draft.isValid) {
      throw Exception(
        'StoryDraft is not valid.',
      );
    }

    final doc =
    _storiesCollection(familyId).doc();

    final now = DateTime.now();

    final story = Story(
      id: doc.id,
      familyId: familyId,
      title: draft.title.trim(),
      content: draft.content.trim(),
      authorId: authorId,
      isQuote: draft.isQuote,
      createdAt: now,
      updatedAt: now,
    );

    await doc.set(
      story.toMap(),
    );

    return story;
  }

  // ---------------------------------------------------------------------------
  // GET ONE
  // ---------------------------------------------------------------------------

  Future<Story?> getStory({
    required String familyId,
    required String storyId,
  }) async {
    final snapshot =
    await _storiesCollection(
      familyId,
    ).doc(storyId).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return Story.fromMap(data);
  }

  // ---------------------------------------------------------------------------
  // GET ALL
  // ---------------------------------------------------------------------------

  Future<List<Story>> getStories({
    required String familyId,
  }) async {
    final snapshot =
    await _storiesCollection(
      familyId,
    )
        .orderBy(
      'createdAt',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => Story.fromMap(
        doc.data(),
      ),
    )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // STREAM
  // ---------------------------------------------------------------------------

  Stream<List<Story>> watchStories({
    required String familyId,
  }) {
    return _storiesCollection(
      familyId,
    )
        .orderBy(
      'createdAt',
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Story.fromMap(
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // QUOTES ONLY
  // ---------------------------------------------------------------------------

  Future<List<Story>> getQuotes({
    required String familyId,
  }) async {
    final snapshot =
    await _storiesCollection(
      familyId,
    )
        .where(
      'isQuote',
      isEqualTo: true,
    )
        .orderBy(
      'createdAt',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => Story.fromMap(
        doc.data(),
      ),
    )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // STORIES ONLY
  // ---------------------------------------------------------------------------

  Future<List<Story>> getFamilyStories({
    required String familyId,
  }) async {
    final snapshot =
    await _storiesCollection(
      familyId,
    )
        .where(
      'isQuote',
      isEqualTo: false,
    )
        .orderBy(
      'createdAt',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => Story.fromMap(
        doc.data(),
      ),
    )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<void> updateStory(
      Story story,
      ) async {
    final updatedStory =
    story.copyWith(
      updatedAt: DateTime.now(),
    );

    await _storiesCollection(
      story.familyId,
    )
        .doc(
      story.id,
    )
        .update(
      updatedStory.toMap(),
    );
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<void> deleteStory(
      Story story,
      ) async {
    await _storiesCollection(
      story.familyId,
    )
        .doc(
      story.id,
    )
        .delete();
  }
}