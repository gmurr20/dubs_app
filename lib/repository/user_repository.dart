import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubs_app/common/common_errors.dart';
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
        checkAndPrint(email) +
        "' and a password");

    // check that user is not signed in
    var currentUser = await _auth.currentUser();
    if (currentUser != null) {
      _logger.e("loginUser- A user is already signed in!");
      return Future.error("User is already signed in. Please log out");
    }

    // attempt to create the user
    AuthResult result;
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _logger.w("createUser- Caught exception when adding user. Message '" +
          e.toString() +
          "'");
      return Future.error(e.toString());
    }

    // send email verification
    try {
      await result.user.sendEmailVerification();
    } catch (e) {
      _logger.w("createUser- Failed to send email to user. Message '" +
          e.toString() +
          "'");
    }
    return User(result.user.uid, result.user.email, null, null,
        UserAuthState.NOT_VERIFIED);
  }

  // Logging in a user with an email and password
  Future<User> loginUser(String email, String password) async {
    _logger.d("loginUser- Entered login user with email '" +
        checkAndPrint(email) +
        "' and a password");
    var currentUser = await _auth.currentUser();
    if (currentUser != null) {
      _logger.e("loginUser- A user is already signed in!");
      return Future.error("User is already signed in. Please logout");
    }
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _logger.w("loginUser- Failed to login! Error: '" + e.toString() + "'");
      return Future.error("Failed to login! Error: " + e.toString());
    }

    return await _userFromFirebase(result.user);
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
    return await _userFromFirebase(user);
  }

  // is the user logged in
  Future<bool> isLoggedIn() async {
    return (await _auth.currentUser()) != null;
  }

  // sends an email verification to the user
  Future<void> sendEmailVerification() async {
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
    if (userInfo.username == null) {
      _logger.e("setUserData- No username");
      return Future.error("No username is set");
    }
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("setUserData- User is not signed in");
      return Future.error("User is not signed in");
    }

    _logger.v("setUserData- Setting user data");

    String errorMessage = "Network error";
    try {
      await _store.runTransaction((transaction) async {
        String usernameId = userInfo.username.toLowerCase();
        DocumentSnapshot username = await transaction
            .get(_store.collection("usernames").document(usernameId));
        if (username.exists) {
          _logger.i("setUserData- username already exists");
          transaction.set(_store.collection("usernames").document(usernameId),
              username.data);
          errorMessage = "Username is taken";
          return Future.error("Username is taken");
        }
        await transaction.set(
            _store.collection("usernames").document(usernameId),
            {"userid": user.uid, "displayName": userInfo.username});
        return transaction.set(_store.collection("users").document(user.uid),
            {"username": usernameId});
      });
    } catch (e) {
      _logger.e("setUserData- Caught error when running transaction '" +
          e.toString() +
          "'");
      return Future.error(errorMessage);
    }
  }

  Future<void> logout() async {
    _logger.v("logout- logging out");
    if (!await isLoggedIn()) {
      _logger.d("logout- user is not logged in");
      return;
    }
    return await _auth.signOut();
  }

  // reloads the user and their information
  Future<User> reloadUser() async {
    _logger.d("reloadUser- Enter");
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("reloadUser- User is not logged in");
      return Future.error("User is not logged in");
    }
    await user.reload();
    return await getUser();
  }

  // private function to convert the firebase user to our internal user
  Future<User> _userFromFirebase(FirebaseUser fbUser) async {
    _logger.v("_userFromFirebase- entering with uid '" + fbUser.uid + "'");
    if (!fbUser.isEmailVerified) {
      _logger.v("_userFromFirebase- email is not verified");
      return User(
          fbUser.uid, fbUser.email, null, null, UserAuthState.NOT_VERIFIED);
    }
    List<DocumentSnapshot> documentQuery;
    try {
      documentQuery = (await _store
              .collection("usernames")
              .where("userid", isEqualTo: fbUser.uid)
              .getDocuments())
          .documents;
    } catch (e) {
      _logger.e("_userFromFirebase- Could not contact backend. Error '" +
          e.toString() +
          "'");
      return Future.error(e.toString());
    }

    if (documentQuery.isEmpty) {
      _logger.v("_userFromFirebase- no username");
      return User(
          fbUser.uid, fbUser.email, null, null, UserAuthState.NO_USERNAME);
    }
    _logger.v("_userFromFirebase- found username");
    String username = documentQuery[0].data["username"];
    return User(fbUser.uid, fbUser.email, username, null,
        UserAuthState.FULLY_LOGGED_IN);
  }
}
