import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartEvent extends LoginEvent {
  @override
  String toString() => 'AppStartEvent';
}

class LoginUserEvent extends LoginEvent {
  final String _email;
  final String _password;

  LoginUserEvent(this._email, this._password);

  String get email => _email;

  String get password => _password;

  @override
  String toString() => 'LoginUserEvent';
}
