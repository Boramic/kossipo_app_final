import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/memory_type.dart';

class MediaUploadService {
  MediaUploadService({
    FirebaseStorage? storage,
  }) : _storage =
      storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  // ---------------------------------------------------------------------------
  // PUBLIC API
  // ---------------------------------------------------------------------------

  Future<String> uploadMedia({
    required String familyId,
    required String memoryId,
    required MemoryType type,
    required String localPath,
  }) async {
    final file = File(localPath);

    if (!file.existsSync()) {
      throw Exception(
        'Media file does not exist.',
      );
    }

    final storagePath =
    _buildStoragePath(
      familyId: familyId,
      memoryId: memoryId,
      type: type,
      localPath: localPath,
    );

    final reference =
    _storage.ref(storagePath);

    final metadata =
    SettableMetadata(
      contentType:
      _contentTypeFor(
        type,
      ),
    );

    final task =
    reference.putFile(
      file,
      metadata,
    );

    final snapshot =
    await task;

    return snapshot.ref
        .getDownloadURL();
  }

  Future<void> deleteMedia(
      String mediaUrl,
      ) async {
    if (mediaUrl.trim().isEmpty) {
      return;
    }

    try {
      await _storage
          .refFromURL(
        mediaUrl,
      )
          .delete();
    } catch (_) {}
  }

  Future<String> replaceMedia({
    required String oldMediaUrl,
    required String familyId,
    required String memoryId,
    required MemoryType type,
    required String localPath,
  }) async {
    await deleteMedia(
      oldMediaUrl,
    );

    return uploadMedia(
      familyId: familyId,
      memoryId: memoryId,
      type: type,
      localPath: localPath,
    );
  }

  // ---------------------------------------------------------------------------
  // INTERNAL
  // ---------------------------------------------------------------------------

  String _buildStoragePath({
    required String familyId,
    required String memoryId,
    required MemoryType type,
    required String localPath,
  }) {
    final extension =
    _extractExtension(
      localPath,
    );

    final folder =
    switch (type) {
      MemoryType.image =>
      'images',

      MemoryType.video =>
      'videos',

      MemoryType.voice =>
      'voices',
    };

    return
      'families/'
          '$familyId/'
          'memories/'
          '$folder/'
          '$memoryId.$extension';
  }

  String _extractExtension(
      String path,
      ) {
    final segments =
    path.split('.');

    if (segments.length < 2) {
      return 'bin';
    }

    return segments.last
        .toLowerCase();
  }

  String _contentTypeFor(
      MemoryType type,
      ) {
    switch (type) {
      case MemoryType.image:
        return 'image/jpeg';

      case MemoryType.video:
        return 'video/mp4';

      case MemoryType.voice:
        return 'audio/m4a';
    }
  }
}