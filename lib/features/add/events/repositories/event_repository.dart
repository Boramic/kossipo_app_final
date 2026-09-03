import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_draft.dart';
import '../models/family_event.dart';

class EventRepository {
  EventRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
      firestore ??
          FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection =
      'family_events';

  // --------------------------------------------------
  // CREATE
  // --------------------------------------------------

  Future<String> createEvent({
    required String familyId,
    required String authorId,
    required EventDraft draft,
  }) async {
    if (!draft.isValid) {
      throw Exception(
        'Invalid event draft.',
      );
    }

    final doc =
    _firestore
        .collection(
      _collection,
    )
        .doc();

    final now = DateTime.now();

    final event = FamilyEvent(
      id: doc.id,
      familyId: familyId,
      authorId: authorId,
      type: draft.type,
      title: draft.title.trim(),
      description:
      draft.description.trim(),
      location:
      draft.location.trim(),
      startDate: draft.startDate!,
      endDate: draft.endDate!,
      isAllDay: draft.isAllDay,
      createdAt: now,
      updatedAt: now,
    );

    await doc.set(
      event.toMap(),
    );

    return doc.id;
  }

  // --------------------------------------------------
  // GET EVENT
  // --------------------------------------------------

  Future<FamilyEvent?> getEvent(
      String eventId,
      ) async {
    final snapshot =
    await _firestore
        .collection(
      _collection,
    )
        .doc(eventId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    return FamilyEvent.fromMap(
      snapshot.data()!,
    );
  }

  // --------------------------------------------------
  // FAMILY EVENTS
  // --------------------------------------------------

  Stream<List<FamilyEvent>>
  watchFamilyEvents(
      String familyId,
      ) {
    return _firestore
        .collection(
      _collection,
    )
        .where(
      'familyId',
      isEqualTo: familyId,
    )
        .orderBy(
      'startDate',
      descending: false,
    )
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map(
                (doc) =>
                FamilyEvent.fromMap(
                  doc.data(),
                ),
          )
              .toList(),
    );
  }

  // --------------------------------------------------
  // UPCOMING EVENTS
  // --------------------------------------------------

  Stream<List<FamilyEvent>>
  watchUpcomingEvents(
      String familyId,
      ) {
    return _firestore
        .collection(
      _collection,
    )
        .where(
      'familyId',
      isEqualTo: familyId,
    )
        .where(
      'endDate',
      isGreaterThan:
      Timestamp.fromDate(
        DateTime.now(),
      ),
    )
        .orderBy(
      'endDate',
    )
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map(
                (doc) =>
                FamilyEvent.fromMap(
                  doc.data(),
                ),
          )
              .toList(),
    );
  }

  // --------------------------------------------------
  // UPDATE
  // --------------------------------------------------

  Future<void> updateEvent({
    required String eventId,
    required EventDraft draft,
  }) async {
    if (!draft.isValid) {
      throw Exception(
        'Invalid event draft.',
      );
    }

    await _firestore
        .collection(
      _collection,
    )
        .doc(eventId)
        .update({
      'title': draft.title.trim(),
      'description':
      draft.description.trim(),
      'location':
      draft.location.trim(),
      'startDate':
      Timestamp.fromDate(
        draft.startDate!,
      ),
      'endDate':
      Timestamp.fromDate(
        draft.endDate!,
      ),
      'isAllDay':
      draft.isAllDay,
      'updatedAt':
      Timestamp.fromDate(
        DateTime.now(),
      ),
    });
  }

  // --------------------------------------------------
  // DELETE
  // --------------------------------------------------

  Future<void> deleteEvent(
      String eventId,
      ) async {
    await _firestore
        .collection(
      _collection,
    )
        .doc(eventId)
        .delete();
  }
}