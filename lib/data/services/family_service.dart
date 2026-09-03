import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FamilyService {
  FamilyService._();

  static final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// CREATE FAMILY
  static Future<String> createFamily({
    required String familyName,
    required String familyCode,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception(
        "User not authenticated",
      );
    }

    final normalizedCode =
    familyCode.trim().toUpperCase();

    /// CHECK IF CODE ALREADY EXISTS
    final existingFamily =
    await _db
        .collection("families")
        .where(
      "code",
      isEqualTo: normalizedCode,
    )
        .limit(1)
        .get();

    if (existingFamily.docs.isNotEmpty) {
      throw Exception(
        "Family code already exists",
      );
    }

    final familyRef =
    _db.collection("families").doc();

    await familyRef.set({
      "id": familyRef.id,
      "name": familyName.trim(),
      "code": normalizedCode,
      "ownerId": user.uid,
      "members": [user.uid],
      "createdAt":
      FieldValue.serverTimestamp(),
      "updatedAt":
      FieldValue.serverTimestamp(),
    });

    /// LINK USER TO FAMILY
    await _db
        .collection("users")
        .doc(user.uid)
        .set(
      {
        "familyId": familyRef.id,
        "familyName": familyName.trim(),
        "familyCode": normalizedCode,
        "role": "owner",
        "updatedAt":
        FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return familyRef.id;
  }

  /// JOIN FAMILY
  static Future<bool> joinFamily(
      String familyCode,
      ) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception(
        "User not authenticated",
      );
    }

    final normalizedCode =
    familyCode.trim().toUpperCase();

    final familyQuery =
    await _db
        .collection("families")
        .where(
      "code",
      isEqualTo: normalizedCode,
    )
        .limit(1)
        .get();

    if (familyQuery.docs.isEmpty) {
      return false;
    }

    final familyDoc =
        familyQuery.docs.first;

    final familyId = familyDoc.id;

    /// ADD USER TO FAMILY
    await _db
        .collection("families")
        .doc(familyId)
        .update({
      "members": FieldValue.arrayUnion(
        [user.uid],
      ),
      "updatedAt":
      FieldValue.serverTimestamp(),
    });

    /// LINK USER PROFILE
    await _db
        .collection("users")
        .doc(user.uid)
        .set(
      {
        "familyId": familyId,
        "familyName":
        familyDoc["name"],
        "familyCode":
        familyDoc["code"],
        "role": "member",
        "joinedAt":
        FieldValue.serverTimestamp(),
        "updatedAt":
        FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return true;
  }
}