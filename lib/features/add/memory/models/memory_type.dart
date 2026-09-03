enum MemoryType {
  image,
  video,
  voice;

  String get id {
    switch (this) {
      case MemoryType.image:
        return 'image';

      case MemoryType.video:
        return 'video';

      case MemoryType.voice:
        return 'voice';
    }
  }

  String get label {
    switch (this) {
      case MemoryType.image:
        return 'Image Memory';

      case MemoryType.video:
        return 'Video Memory';

      case MemoryType.voice:
        return 'Voice Memory';
    }
  }

  bool get requiresMedia {
    switch (this) {
      case MemoryType.image:
      case MemoryType.video:
      case MemoryType.voice:
        return true;
    }
  }

  static MemoryType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'image':
        return MemoryType.image;

      case 'video':
        return MemoryType.video;

      case 'voice':
        return MemoryType.voice;

      default:
        throw ArgumentError(
          'Unsupported MemoryType: $value',
        );
    }
  }
}