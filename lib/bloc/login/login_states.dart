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

// user entered an invalid input
class InvalidInputState extends LoginState {
  final String emailError;
  final String passwordError;

  InvalidInputState(this.emailError, this.passwordError);

  @override
  String toString() => 'InvalidInputState';
}

// An error happened on authentication
class AuthenticationErrorState extends LoginState {
  final String errorMessage;

  AuthenticationErrorState(this.errorMessage);

  @override
  String toString() => 'AuthenticationErrorState';
}

// User login is valid but user is not verified
class UnverifiedUserState extends LoginState {
  final User user;

  UnverifiedUserState(this.user);

  @override
  String toString() => 'UnverifiedUserState';
}
