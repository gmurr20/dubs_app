// Represents a user in the app
class User {
  String _username;
  String _iconUrl;
  bool _isVerified;

  User(this._username, this._iconUrl, this._isVerified);

  String get username => _username;

  String get iconUrl => _iconUrl;

  bool get isVerified => _isVerified;
}
