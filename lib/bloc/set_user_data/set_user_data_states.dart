import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SetUserDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotSetState extends SetUserDataState {
  @override
  String toString() => 'NotSetState';
}

class ErrorState extends SetUserDataState {
  String usernameError;

  ErrorState(this.usernameError);

  @override
  String toString() => 'ErrorState';
}

class AttemptingToContactState extends SetUserDataState {
  @override
  String toString() => 'AttemptingToContactState';
}

class NotLoggedInState extends SetUserDataState {
  @override
  String toString() => 'NotLoggedInState';
}

class DataSetState extends SetUserDataState {
  @override
  String toString() => 'DataSetState';
}
