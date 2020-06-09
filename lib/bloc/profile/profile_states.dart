import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileLoggedOutState extends ProfileState {
  ProfileLoggedOutState();

  @override
  String toString() => 'ProfileLoggedOutState';
}

class NormalState extends ProfileState {
  User currentUser;

  NormalState(this.currentUser);
  @override
  String toString() => 'ProfileState';
}
