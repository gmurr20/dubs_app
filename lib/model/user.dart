enum UserAuthState { NOT_VERIFIED, NO_USERNAME, FULLY_LOGGED_IN }

// Represents a user in the app
class User {
  String _userid;
  String _email;
  String _username;
  String _iconUrl;
  UserAuthState _authState;

  User(this._userid, this._email, this._username, this._iconUrl,
      this._authState);

  String get userid => _userid;

  String get email => _email;

  String get username => _username;

  String get iconUrl => _iconUrl;

  UserAuthState get authState => _authState;
}

// Data for a user that can be changed
class MutableUserData {
  String username;

  MutableUserData(this.username);
}
