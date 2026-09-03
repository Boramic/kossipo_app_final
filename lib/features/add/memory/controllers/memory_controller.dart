import 'package:flutter/foundation.dart';

import '../models/memory.dart';
import '../models/memory_draft.dart';
import '../models/memory_type.dart';

class MemoryController extends ChangeNotifier {
MemoryController({
required MemoryType type,
}) : _draft = MemoryDraft.empty(type);

MemoryDraft _draft;

bool _saving = false;

// ---------------------------------------------------------------------------
// GETTERS
// ---------------------------------------------------------------------------

MemoryDraft get draft => _draft;

bool get isSaving => _saving;

bool get hasMedia => _draft.hasMedia;

bool get canContinue =>
_draft.isValid && !_saving;

MemoryType get type =>
_draft.type;

// ---------------------------------------------------------------------------
// INTERNAL
// ---------------------------------------------------------------------------

void _updateDraft(
MemoryDraft newDraft,
) {
_draft = newDraft;
notifyListeners();
}

// ---------------------------------------------------------------------------
// BASIC FIELDS
// ---------------------------------------------------------------------------

void setTitle(
String value,
) {
_updateDraft(
_draft.copyWith(
title: value.trim(),
),
);
}

void setDescription(
String value,
) {
_updateDraft(
_draft.copyWith(
description: value.trim(),
),
);
}

void setLocation(
String value,
) {
_updateDraft(
_draft.copyWith(
location: value.trim(),
),
);
}

void setDate(
DateTime value,
) {
_updateDraft(
_draft.copyWith(
capturedDate: value,
),
);
}

// ---------------------------------------------------------------------------
// MEDIA
// ---------------------------------------------------------------------------

void setMediaPath(
String path,
) {
_updateDraft(
_draft.copyWith(
mediaPath: path.trim(),
),
);
}

void removeMedia() {
_updateDraft(
_draft.copyWith(
mediaPath: null,
),
);
}

// ---------------------------------------------------------------------------
// FAMILY LINKS
// ---------------------------------------------------------------------------

void setPrimaryPerson(
String? personId,
) {
_updateDraft(
_draft.copyWith(
primaryPersonId: personId,
),
);
}

void clearPrimaryPerson() {
_updateDraft(
_draft.copyWith(
primaryPersonId: null,
),
);
}

void setTaggedMembers(
List<String> memberIds,
) {
final uniqueMembers = memberIds
    .where(
(id) => id.trim().isNotEmpty,
)
    .toSet()
    .toList();

_updateDraft(
_draft.copyWith(
taggedMembers: uniqueMembers,
),
);
}

void addTaggedMember(
String memberId,
) {
final id = memberId.trim();

if (id.isEmpty) {
return;
}

if (_draft.taggedMembers.contains(id)) {
return;
}

_updateDraft(
_draft.copyWith(
taggedMembers: [
..._draft.taggedMembers,
id,
],
),
);
}

void removeTaggedMember(
String memberId,
) {
final members = [
..._draft.taggedMembers,
];

members.remove(memberId);

_updateDraft(
_draft.copyWith(
taggedMembers: members,
),
);
}

void clearTaggedMembers() {
_updateDraft(
_draft.copyWith(
taggedMembers: const [],
),
);
}

// ---------------------------------------------------------------------------
// SAVE
// ---------------------------------------------------------------------------

Future<void> save(
Future<void> Function(
MemoryDraft draft,
)
repository,
) async {
if (_saving) {
return;
}

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
// CONVERSION
// ---------------------------------------------------------------------------

Memory toMemory({
required String id,
required String familyId,
required String createdBy,
required DateTime createdAt,
}) {
final now = DateTime.now();

return Memory(
id: id,
familyId: familyId,
type: _draft.type,
title: _draft.title,
description: _draft.description,
location: _draft.location,
mediaUrl: _draft.mediaPath ?? '',
capturedDate: _draft.capturedDate,
primaryPersonId: _draft.primaryPersonId,
taggedMembers: List.unmodifiable(
_draft.taggedMembers,
),
createdBy: createdBy,
createdAt: createdAt,
updatedAt: now,
);
}

// ---------------------------------------------------------------------------
// RESET
// ---------------------------------------------------------------------------

void reset() {
_draft = MemoryDraft.empty(
_draft.type,
);

notifyListeners();
}
}
