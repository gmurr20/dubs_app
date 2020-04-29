import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserEvent extends NewUserEvent {
  final String _email;
  final String _username;
  final String _password1;
  final String _password2;

  String get email => _email;

  String get username => _username;

  String get password1 => _password1;

  String get password2 => _password2;

  AddUserEvent(this._email, this._username, this._password1, this._password2);

  @override
  String toString() => 'AddUserEvent';
}
