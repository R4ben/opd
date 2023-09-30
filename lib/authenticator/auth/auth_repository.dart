import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user/user_models.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  User currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.additionalUserInfo!.isNewUser) {
        _firebaseFirestore.doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'name': "Nome",
          'photo': '',
          'phone': 'Phone',
          'notes': 'Diz algo sobre si.',
        });
      }
    } catch (_) {}
  }

  Future<String> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  Future<void> updateUserName(String userName) async {
    final firebase_auth.User? user = _firebaseAuth.currentUser;

    try {
      user?.updateDisplayName(userName);
    } catch (_) {}
  }

  Future<void> updateUserPhone(
      firebase_auth.PhoneAuthCredential phoneNumber) async {
    final firebase_auth.User? user = _firebaseAuth.currentUser;

    try {
      user?.updatePhoneNumber((phoneNumber));
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
