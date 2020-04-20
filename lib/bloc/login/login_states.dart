import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

// app just started
class AppStartState extends LoginState {
  @override
  String toString() => 'AppStartState';
}

// user is not logged in
class NotLoggedInState extends LoginState {
  @override
  String toString() => 'NotLoggedInState';
}

// user has sent request to login and is waiting for response
class LoginLoadingState extends LoginState {
  @override
  String toString() => 'LoginLoadingState';
}

// user has logged in successfully
class LoggedInState extends LoginState {
  final User user;

  LoggedInState(this.user);

  @override
  String toString() => 'LoggedInState';
}

// user has encountered an error while logging in
class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);

  @override
  String toString() => 'LoginErrorState';
}
