import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

abstract class AuthBase {
  Stream<User> get authStateChanged;
  User currentUser();
  Future<void> signInWithEmailAndPassword({email, password});
  Future<void> signUpWithEmailAndPassword({email, password});
  Future<void> changePassword(password);
  Future<void> changeName(name);
  Future<void> changeEmail(email);
  Future<void> sendPasswordResetEmail(email);
  Future<void> logout();
}

class AuthenticationService extends AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> get authStateChanged =>
      _firebaseAuth.authStateChanges().map((User user) => user);

  @override
  Future<void> changeEmail(email) async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.updateEmail(email);
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<void> changeName(name) async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.updateProfile(displayName: name);
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(password) async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.updatePassword(password);
    } on PlatformException {
      rethrow;
    }
  }

  @override
  User currentUser() {
    try {
      final user = _firebaseAuth.currentUser;
      return user;
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({email, password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({email, password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException {
      rethrow;
    }
  }
}
