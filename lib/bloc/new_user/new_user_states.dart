import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewUserState extends Equatable {
  @override
  List<Object> get props => [];
}

// not logged in
class NotLoggedInNewState extends NewUserState {
  @override
  String toString() => 'NotLoggedInState';
}

// attempting to contact repo
class LoadingState extends NewUserState {
  @override
  String toString() => 'LoadingState';
}

class InvalidInputState extends NewUserState {
  final String emailError;
  final String password1Error;
  final String password2Error;

  InvalidInputState(this.emailError, this.password1Error, this.password2Error);

  @override
  String toString() => 'InvalidInputState';
}

class LoginErrorState extends NewUserState {
  final String error;

  LoginErrorState(this.error);

  @override
  String toString() => 'LoginErrorState';
}

// user is not logged in
class LoggedInState extends NewUserState {
  final User user;

  LoggedInState(this.user);

  @override
  String toString() => 'LoggedInState';
}
