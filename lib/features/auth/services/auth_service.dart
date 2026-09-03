import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Current user
  static User? get currentUser => _auth.currentUser;

  // SIGN UP
  static Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _db.collection('users').doc(credential.user!.uid).set({
      "uid": credential.user!.uid,
      "fullName": fullName,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return credential;
  }

  // SIGN IN
  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // FORGOT PASSWORD
  static Future<void> forgotPassword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  // UPDATE USER DATA
  static Future<void> updateUserData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection('users').doc(uid).update(data);
  }

  // SIGN OUT
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}