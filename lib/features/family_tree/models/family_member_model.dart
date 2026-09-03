import 'dart:ui';

class FamilyMemberModel {
  /// UNIQUE IDENTIFIERS
  final String id;
  final String familyId;
  final String? parentId;

  /// BASIC INFO
  final String fullName;
  final String imageUrl;
  final String gender;
  final String relationship;

  /// PERSONAL DETAILS
  final DateTime birthDate;
  final String maritalStatus;
  final String profession;
  final String biography;
  final String location;

  /// TREE STRUCTURE
  final int generation;
  final List<FamilyMemberModel> children;

  /// STATUS FLAGS
  final bool isAlive;
  final bool isRoot;
  final bool isVerified;
  final bool isHighlighted;

  /// DIGITAL MEMORY COUNTS
  final int totalMemories;
  final int totalPhotos;
  final int totalVideos;
  final int totalVoices;
  final int totalDocuments;

  /// DIGITAL CONTENT
  final List<String> memories;
  final List<String> videos;
  final List<String> voiceNotes;
  final List<String> documents;

  /// OPTIONAL FAMILY META
  final String? clanName;
  final String? bloodGroup;
  final String? nationality;
  final String? religion;

  /// TIMESTAMPS
  final DateTime createdAt;
  final DateTime updatedAt;
  final Offset position;

  const FamilyMemberModel({
    required this.id,
    required this.familyId,
    this.parentId,

    required this.fullName,
    required this.imageUrl,
    required this.gender,
    required this.relationship,
    required this.position,

    required this.birthDate,
    required this.maritalStatus,
    required this.profession,
    required this.biography,
    required this.location,

    required this.generation,
    required this.children,

    this.isAlive = true,
    this.isRoot = false,
    this.isVerified = false,
    this.isHighlighted = false,

    this.totalMemories = 0,
    this.totalPhotos = 0,
    this.totalVideos = 0,
    this.totalVoices = 0,
    this.totalDocuments = 0,

    this.memories = const [],
    this.videos = const [],
    this.voiceNotes = const [],
    this.documents = const [],

    this.clanName,
    this.bloodGroup,
    this.nationality,
    this.religion,

    required this.createdAt,
    required this.updatedAt,
  });

  /// AGE CALCULATOR
  int get age {
    final now = DateTime.now();
    int years = now.year - birthDate.year;

    if (
    now.month < birthDate.month ||
        (now.month == birthDate.month &&
            now.day < birthDate.day)
    ) {
      years--;
    }

    return years;
  }

  /// HAS CHILDREN
  bool get hasChildren => children.isNotEmpty;

  /// TOTAL MEDIA
  int get totalMedia =>
      memories.length +
          videos.length +
          voiceNotes.length +
          documents.length;

  /// COPY WITH
  FamilyMemberModel copyWith({
    String? fullName,
    String? imageUrl,
    String? profession,
    String? biography,
    String? location,
    List<FamilyMemberModel>? children,
    bool? isHighlighted,
  }) {
    return FamilyMemberModel(
      id: id,
      familyId: familyId,
      parentId: parentId,

      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender,
      relationship: relationship,
      position: position,

      birthDate: birthDate,
      maritalStatus: maritalStatus,
      profession: profession ?? this.profession,
      biography: biography ?? this.biography,
      location: location ?? this.location,

      generation: generation,
      children: children ?? this.children,

      isAlive: isAlive,
      isRoot: isRoot,
      isVerified: isVerified,
      isHighlighted:
      isHighlighted ?? this.isHighlighted,

      totalMemories: totalMemories,
      totalPhotos: totalPhotos,
      totalVideos: totalVideos,
      totalVoices: totalVoices,
      totalDocuments: totalDocuments,

      memories: memories,
      videos: videos,
      voiceNotes: voiceNotes,
      documents: documents,

      clanName: clanName,
      bloodGroup: bloodGroup,
      nationality: nationality,
      religion: religion,

      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// FIRESTORE JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'parentId': parentId,
      'fullName': fullName,
      'imageUrl': imageUrl,
      'gender': gender,
      'relationship': relationship,
      'birthDate': birthDate.toIso8601String(),
      'maritalStatus': maritalStatus,
      'profession': profession,
      'biography': biography,
      'location': location,
      'generation': generation,
      'isAlive': isAlive,
      'isRoot': isRoot,
      'isVerified': isVerified,
      'memories': memories,
      'videos': videos,
      'voiceNotes': voiceNotes,
      'documents': documents,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FamilyMemberModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return FamilyMemberModel(
      id: map['id'],
      familyId: map['familyId'],
      parentId: map['parentId'],

      fullName: map['fullName'],
      imageUrl: map['imageUrl'],
      gender: map['gender'],
      relationship: map['relationship'],
      position: Offset(
        (map['position']?['dx'] ?? 0).toDouble(),
        (map['position']?['dy'] ?? 0).toDouble(),
      ),

      birthDate: DateTime.parse(
        map['birthDate'],
      ),

      maritalStatus: map['maritalStatus'],
      profession: map['profession'],
      biography: map['biography'],
      location: map['location'],

      generation: map['generation'],
      children: const [],

      isAlive: map['isAlive'] ?? true,
      isRoot: map['isRoot'] ?? false,
      isVerified: map['isVerified'] ?? false,

      memories:
      List<String>.from(map['memories'] ?? []),
      videos:
      List<String>.from(map['videos'] ?? []),
      voiceNotes: List<String>.from(
        map['voiceNotes'] ?? [],
      ),
      documents: List<String>.from(
        map['documents'] ?? [],
      ),

      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      updatedAt: DateTime.parse(
        map['updatedAt'],
      ),
    );
  }
}