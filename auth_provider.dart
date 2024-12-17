import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with Email and Password
  Future<String?> registerWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // No errors
    } catch (e) {
      return e.toString();
    }
  }

  // Login with Email and Password
  Future<String?> loginWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
 // Send Password Reset Email
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Password reset email sent! Check your inbox.";
    } on FirebaseAuthException catch (e) {
      return e.message; // Return the error message
    }
  }
  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check User Authentication Status
  User? get currentUser => _auth.currentUser;
}
