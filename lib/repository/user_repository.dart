import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubs_app/common/common_errors.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
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
  Future<User> setUserData(MutableUserData userInfo) async {
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

    bool usernameTaken = false;
    try {
      await _store.runTransaction((transaction) async {
        String usernameId = userInfo.username.toLowerCase();
        DocumentSnapshot username = await transaction
            .get(_store.collection("usernames").document(usernameId));
        if (username.exists) {
          _logger.i("setUserData- username already exists");
          usernameTaken = true;
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
      return Future.error(e.toString());
    }

    if (usernameTaken) {
      return Future.error("username is taken");
    }

    return await getUser();
  }

  Future<List<UserSearchResult>> searchForFriends(String searchString) async {
    _logger.v("searchForFriends- Entered");
    final user = await _auth.currentUser();
    if (user == null) {
      _logger.e("searchForFriends- User is not signed in");
      return Future.error("User is not signed in");
    }

    // TODO: Use Algolia for real searching capabilities
    // this is just a hack
    // 1) search for the username in the database
    List<String> searchStart = List<String>();
    searchStart.add(searchString);
    List<String> searchEnd = List<String>();
    searchEnd.add(searchString + "\uf8ff");
    QuerySnapshot usernameSearchQ;
    try {
      usernameSearchQ = await _store
          .collection("usernames")
          .orderBy(FieldPath.documentId)
          .startAt(searchStart)
          .endAt(searchEnd)
          .getDocuments();
    } catch (e) {
      _logger.e(
          "searchForFriends- caught error when searching usernames ${e.toString()}");
      return Future.error("Username query failed ${e.toString()}");
    }
    _logger.v(
        "searchForFriends- got ${usernameSearchQ.documents.length} search results back");
    List<UserSearchResult> searchResults = List<UserSearchResult>();
    if (usernameSearchQ.documents.isEmpty) {
      _logger.v(
          "searchForFriends- username search returned no results with search ${searchString}");
      return searchResults;
    }

    // 2) search through the users existing friend requests
    QuerySnapshot friendRequestQ;
    try {
      friendRequestQ = await _store
          .collection("users")
          .document(user.uid)
          .collection("friend_requests")
          .getDocuments();
    } catch (e) {
      _logger.w(
          "searchForFriends- friend requests search returned with error ${e.toString()}");
      return Future.error(
          "A network error ocurred. Make sure your connection is fine");
    }

    // 3) search through the users existing friends
    QuerySnapshot friendsQ;
    try {
      friendsQ = await _store
          .collection("users")
          .document(user.uid)
          .collection("friends")
          .getDocuments();
    } catch (e) {
      _logger.w(
          "searchForFriends- friends search returned with error ${e.toString()}");
      return Future.error(
          "A network error ocurred. Make sure your connection is fine");
    }

    // 4) compare the existing friend requests and friends with the search results
    Map<String, UserRelationshipState> userIdToRelationship =
        Map<String, UserRelationshipState>();
    for (int i = 0; i < friendRequestQ.documents.length; i++) {
      userIdToRelationship[friendRequestQ.documents[i].documentID] =
          UserSearchResult.friendRequestStringToEnum(
              friendRequestQ.documents[i].data["status"]);
    }
    for (int i = 0; i < friendsQ.documents.length; i++) {
      userIdToRelationship[friendsQ.documents[i].documentID] =
          UserRelationshipState.FRIENDS;
    }
    for (int i = 0; i < usernameSearchQ.documents.length; i++) {
      String currSearchId = usernameSearchQ.documents[i].documentID;
      UserRelationshipState relationship;
      if (userIdToRelationship.containsKey(currSearchId)) {
        relationship = userIdToRelationship[currSearchId];
      } else {
        relationship = UserRelationshipState.NOT_FRIENDS;
      }
      searchResults.add(UserSearchResult(currSearchId,
          usernameSearchQ.documents[i].data["displayName"], relationship));
    }
    // return a list of users
    return searchResults;
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
    String username = documentQuery[0].data["displayName"];
    _logger.v("_userFromFirebase- found username ${username}");
    return User(fbUser.uid, fbUser.email, username, null,
        UserAuthState.FULLY_LOGGED_IN);
  }
}
