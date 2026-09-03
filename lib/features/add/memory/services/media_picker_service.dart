import 'package:image_picker/image_picker.dart';

import '../models/memory_type.dart';

class MediaPickerService {
  MediaPickerService({
    ImagePicker? picker,
  }) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  // ---------------------------------------------------------------------------
  // IMAGE
  // ---------------------------------------------------------------------------

  Future<String?> pickImageFromGallery() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      return file?.path;
    } catch (_) {
      return null;
    }
  }

  Future<String?> captureImage() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      return file?.path;
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // VIDEO
  // ---------------------------------------------------------------------------

  Future<String?> pickVideoFromGallery() async {
    try {
      final file = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      return file?.path;
    } catch (_) {
      return null;
    }
  }

  Future<String?> captureVideo() async {
    try {
      final file = await _picker.pickVideo(
        source: ImageSource.camera,
      );

      return file?.path;
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // GENERIC
  // ---------------------------------------------------------------------------

  Future<String?> pickMedia(
      MemoryType type,
      ) async {
    switch (type) {
      case MemoryType.image:
        return pickImageFromGallery();

      case MemoryType.video:
        return pickVideoFromGallery();

      case MemoryType.voice:
        return null;
    }
  }
  Future<String?> pickImage() {
    return pickImageFromGallery();
  }

  Future<String?> pickVideo() {
    return pickVideoFromGallery();
  }
}