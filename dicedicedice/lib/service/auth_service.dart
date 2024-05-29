import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'database_service.dart';

class AuthService with ChangeNotifier {
  // AuthService() {
  //   init();
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // get the current user
  User? get user => _user;

  // Get the uid of the current user
  String? get uid => user?.uid;

  // Stream of authentication state
  // Stream<User?> get currentUser {
  //   if (_user == null) {
  //     return Stream.value(null);
  //   } else {
  //     return Stream.value(_user);
  //   }
  // }
  Stream<User?> get currentUser {
    return _auth.authStateChanges();
  }

  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<User?> signUp(String email, String password, String username) async {
    try {
      print("auth");
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create user documents inthe database with the uid
      await DatabaseService(uid: user!.uid).setUserData(username);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
