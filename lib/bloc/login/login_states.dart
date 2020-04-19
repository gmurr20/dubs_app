import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotLoggedInState extends LoginState {
  @override
  String toString() => 'NotLoggedInState';
}

class LoggedInState extends LoginState {
  final User user;

  LoggedInState(this.user);

  @override
  String toString() => 'LoggedInState';
}
