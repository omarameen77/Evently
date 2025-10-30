import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      
      switch (e.code) {
        case 'user-not-found':
          _errorMessage = 'No user found with this email address.';
          break;
        case 'wrong-password':
          _errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address format.';
          break;
        case 'user-disabled':
          _errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          _errorMessage = 'Too many failed attempts. Please try again later.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        case 'invalid-credential':
          _errorMessage = 'Invalid email or password. Please try again.';
          break;
        default:
          _errorMessage = e.message ?? 'Login failed. Please try again.';
      }
      
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;

      await _firestore.collection('users').doc(_user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _user!.updateDisplayName(name);

      _isLoading = false;
      _errorMessage = null;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account Created Successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;

      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage = 'This email is already registered.';
          break;
        case 'weak-password':
          _errorMessage = 'Password is too weak. Use at least 6 characters.';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address format.';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          _errorMessage = e.message ?? 'Sign up failed. Please try again.';
      }

      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      _user = userCredential.user;

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await _firestore.collection('users').doc(_user!.uid).set({
          'name': _user!.displayName ?? 'No Name',
          'email': _user!.email,
          'photoUrl': _user!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _isLoading = false;
      _errorMessage = null;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;

      switch (e.code) {
        case 'account-exists-with-different-credential':
          _errorMessage = 'An account already exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          _errorMessage = 'Invalid Google credentials.';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Google sign-in is not enabled.';
          break;
        case 'user-disabled':
          _errorMessage = 'This account has been disabled.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          _errorMessage = e.message ?? 'Google sign-in failed.';
      }

      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Google sign-in cancelled or failed.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.signOut();
      await GoogleSignIn().signOut();

      _user = null;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Logout failed. Please try again.';
      notifyListeners();
      debugPrint("Error during logout: $e");
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}