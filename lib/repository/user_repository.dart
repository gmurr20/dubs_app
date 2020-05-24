import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _store = Firestore.instance;

  final _logger = getLogger("UserRepository");

  // First time sign in creating a user with email and password
  Future<User> createUser(String email, String password) async {
    _logger.d("createUser- Entered create user with email '" +
        email +
        "' and a password");
    var currentUser = await _auth.currentUser();
    if (currentUser != null) {
      _logger.e("loginUser- A user is already signed in!");
      return _userFromFirebase(currentUser);
    }
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user.sendEmailVerification();
      return _userFromFirebase(result.user);
    } catch (e) {
      _logger.w(
          "createUser- Caught exception when adding user and sending email. Message '" +
              e.toString() +
              "'");
      return Future.error(e.toString());
    }
  }

  // Logging in a user with an email and password
  Future<User> loginUser(String email, String password) async {
    _logger.d("loginUser- Entered login user with email '" +
        email +
        "' and a password");
    var currentUser = await _auth.currentUser();
    if (currentUser != null) {
      _logger.e("loginUser- A user is already signed in!");
      return _userFromFirebase(currentUser);
    }
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _logger.w("loginUser- Failed to login! Error: '" + e.toString() + "'");
      return Future.error("Failed to login! Error: " + e.toString());
    }
    return _userFromFirebase(result.user);
  }

  // Gets the user object from the current user
  // errors if the user is not signed in
  Future<User> getUser() async {
    _logger.d("getUser- Entered");
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("getUser- User is not signed in");
      return Future.error("User is not signed in");
    }
    return _userFromFirebase(user);
  }

  // is the user logged in
  Future<bool> isLoggedIn() async {
    return (await _auth.currentUser()) != null;
  }

  // sends an email verification to the user
  void sendEmailVerification() async {
    _logger.d("sendEmailVerification- Entered");
    try {
      // grab the current user
      final user = await _auth.currentUser();
      if (user == null) {
        _logger.e("sendEmailVerification- User is not signed in");
        return Future.error("User is not signed in");
      }
      // send email verification
      await user.sendEmailVerification();
    } catch (e) {
      _logger.e("sendEmailVerification- Failed to send email. Error '" +
          e.toString() +
          "'");
      return Future.error(e.toString());
    }
  }

  // sets the user specific information
  Future<void> setUserData(MutableUserData userInfo) async {
    _logger.v("setUserData- Entered");
    if (userInfo.username != null) {
      _logger.e("setUserData- No username");
      return;
    }
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("setUserData- User is not signed in");
      return Future.error("User is not signed in");
    }

    _logger.v("setUserData- Checking that username is unique");
    if (!await usernameCheck(userInfo.username)) {
      _logger.e("setUserData- Username is not unique");
      return;
    }

    _logger.v("setUserData- Changing username");
    try {
      await _store
          .collection('users')
          .document()
          .setData({'userid': user.uid, 'displayName': userInfo.username});
    } catch (e) {
      _logger.e("setUserData- Failed to update user data with error '" +
          e.toString() +
          "'");
      return Future.error(e.toString());
    }
    return;
  }

  // Check that username is unique
  Future<bool> usernameCheck(String username) async {
    _logger.v("usernameCheck- Checking for username '" + username + "'");
    QuerySnapshot result;
    try {
      result = await _store
          .collection('users')
          .where('displayName', isEqualTo: username)
          .getDocuments();
    } catch (e) {
      _logger
          .e("usernameCheck- failed to fetch usernames '" + e.toString() + "'");
      return Future.error(e.toString());
    }
    return result.documents.isEmpty;
  }

  // reloads the user and their information
  Future<User> reloadUser() async {
    _logger.d("reloadUser- Enter");
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("reloadUser- User is not logged in");
      return Future.error("User is not logged in");
    }
    await user
      ..reload();
    return await getUser();
  }

  // private function to convert the firebase user to our internal user
  User _userFromFirebase(FirebaseUser fbUser) {
    return User(fbUser.displayName, fbUser.photoUrl, fbUser.isEmailVerified);
  }
}
