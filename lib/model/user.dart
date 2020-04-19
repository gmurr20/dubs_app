// Represents a user in the app
class User {
  String _username;
  String _iconUrl;

  User(this._username, this._iconUrl);

  String get username => _username;

  String get iconUrl => _iconUrl;
}
