import 'package:dubs_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // First time sign in creating a user with email and password
  Future<User> createUser(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user.sendEmailVerification();
      return _userFromFirebase(result.user);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Logging in a user with an email and password
  Future<User> loginUser(String email, String password) async {
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw ("Failed to login! Error: " + e.toString());
    }
    return _userFromFirebase(result.user);
  }

  Future<bool> isLoggedIn() async {
    try {
      return (await _auth.currentUser()) != null;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<User> getUser() async {
    try {
      final user = await _auth.currentUser();
      if (user == null) {
        return Future.error("User is not signed in");
      }
      return _userFromFirebase(user);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void sendEmailVerification() async {
    try {
      // grab the current user
      final user = await _auth.currentUser();
      if (user == null) {
        return Future.error("User is not signed in");
      }
      // send email verification
      await user.sendEmailVerification();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<User> reloadUser() async {
    final user = await _auth.currentUser();
    if (user == null) {
      throw ("User is not logged in");
    }
    await user
      ..reload();
    return await getUser();
  }

  User _userFromFirebase(FirebaseUser fbUser) {
    return User(fbUser.displayName, fbUser.photoUrl, fbUser.isEmailVerified);
  }
}
