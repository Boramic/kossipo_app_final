import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  // SIGN UP
  static Future<UserCredential> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await credential.user?.updateDisplayName(fullName);

    await _db.collection("users").doc(credential.user!.uid).set({
      "uid": credential.user!.uid,
      "fullName": fullName.trim(),
      "email": email.trim(),
      "photoUrl": "",
      "phone": "",
      "isVerified": false,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return credential;
  }

  // SIGN IN
  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // FORGOT PASSWORD
  static Future<void> forgotPassword({
    required String email,
  }) {
    return _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  // SIGN OUT
  static Future<void> signOut() {
    return _auth.signOut();
  }

  static Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;

    if (user == null) return null;

    final doc = await _db
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data();
  }
}