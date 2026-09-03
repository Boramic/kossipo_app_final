import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/memory.dart';
import '../models/memory_draft.dart';
import '../services/upload_service.dart';

class MemoryRepository {
  MemoryRepository({
    FirebaseFirestore? firestore,
    MediaUploadService? mediaUploadService,
  })  : _firestore =
      firestore ??
          FirebaseFirestore.instance,
        _mediaUploadService =
            mediaUploadService ??
                MediaUploadService();

  final FirebaseFirestore _firestore;

  final MediaUploadService
  _mediaUploadService;

  // ---------------------------------------------------------------------------
  // COLLECTION
  // ---------------------------------------------------------------------------

  CollectionReference<
      Map<String, dynamic>>
  _memoriesCollection(
      String familyId,
      ) {
    return _firestore
        .collection('families')
        .doc(familyId)
        .collection('memories');
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Memory> createMemory({
    required String familyId,
    required String createdBy,
    required MemoryDraft draft,
  }) async {
    if (!draft.isValid) {
      throw Exception(
        'MemoryDraft is not valid.',
      );
    }

    final doc =
    _memoriesCollection(
      familyId,
    ).doc();

    final now = DateTime.now();

    final mediaUrl =
    await _mediaUploadService
        .uploadMedia(
      familyId: familyId,
      memoryId: doc.id,
      type: draft.type,
      localPath:
      draft.mediaPath!,
    );

    final memory = Memory(
      id: doc.id,
      familyId: familyId,
      type: draft.type,
      title: draft.title.trim(),
      description:
      draft.description.trim(),
      location:
      draft.location.trim(),
      mediaUrl: mediaUrl,
      capturedDate:
      draft.capturedDate,
      primaryPersonId:
      draft.primaryPersonId,
      taggedMembers:
      List<String>.from(
        draft.taggedMembers,
      ),
      createdBy: createdBy,
      createdAt: now,
      updatedAt: now,
    );

    await doc.set(
      memory.toMap(),
    );

    return memory;
  }

  // ---------------------------------------------------------------------------
  // GET ONE
  // ---------------------------------------------------------------------------

  Future<Memory?> getMemory({
    required String familyId,
    required String memoryId,
  }) async {
    final snapshot =
    await _memoriesCollection(
      familyId,
    ).doc(memoryId).get();

    if (!snapshot.exists) {
      return null;
    }

    return Memory.fromMap(
      snapshot.data()!,
    );
  }

  // ---------------------------------------------------------------------------
  // GET ALL
  // ---------------------------------------------------------------------------

  Future<List<Memory>>
  getMemories({
    required String familyId,
  }) async {
    final snapshot =
    await _memoriesCollection(
      familyId,
    )
        .orderBy(
      'capturedDate',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) =>
          Memory.fromMap(
            doc.data(),
          ),
    )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // STREAM
  // ---------------------------------------------------------------------------

  Stream<List<Memory>>
  watchMemories({
    required String familyId,
  }) {
    return _memoriesCollection(
      familyId,
    )
        .orderBy(
      'capturedDate',
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map(
                (doc) =>
                Memory.fromMap(
                  doc.data(),
                ),
          )
              .toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<void> updateMemory(
      Memory memory,
      ) async {
    final updatedMemory =
    memory.copyWith(
      updatedAt:
      DateTime.now(),
    );

    await _memoriesCollection(
      memory.familyId,
    )
        .doc(memory.id)
        .update(
      updatedMemory.toMap(),
    );
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<void> deleteMemory(
      Memory memory,
      ) async {
    if (memory.mediaUrl
        .trim()
        .isNotEmpty) {
      await _mediaUploadService
          .deleteMedia(
        memory.mediaUrl,
      );
    }

    await _memoriesCollection(
      memory.familyId,
    )
        .doc(memory.id)
        .delete();
  }
}