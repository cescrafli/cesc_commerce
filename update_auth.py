with open('lib/core/services/auth_service.dart', 'w', encoding='utf-8') as f:
    f.write('''import 'package:firebase_auth/firebase_auth.dart';

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
      print("SignUp Error: \");
      return null;
    }
  }

  // Log in
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print("SignIn Error: \");
      return null;
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("Reset Password Error: \");
      return false;
    }
  }

  // Log out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
''')
print('Updated auth_service.dart')
