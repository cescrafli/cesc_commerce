import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/core/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // Sign up
  Future<User?> signUpWithEmail(String email, String password, {String? fullName}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (fullName != null && result.user != null) {
        await result.user!.updateDisplayName(fullName);
      }
      return result.user;
    } catch (e) {
      if (e is FirebaseAuthException) rethrow;
      debugPrint("SignUp Error: $e");
      return null;
    }
  }

  // Log in
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      if (e is FirebaseAuthException) rethrow;
      debugPrint("SignIn Error: $e");
      return null;
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) rethrow;
      debugPrint("Reset Password Error: $e");
      return false;
    }
  }

  // Log out
  Future<void> signOut() async {
    await _auth.signOut();
    globalUser.value = null; 
    globalCart.value = []; 
    globalOrders.value = []; 
    globalWishlist.value = []; 
    globalAddresses.value = []; 
    globalSelectedAddressIndex.value = -1; 
    globalSavedCards.value = [];
    globalNotifications.value = [];
    UserService.mockProfile.value = {};
  }
}
