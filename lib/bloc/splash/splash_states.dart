import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashStartState extends SplashState {
  @override
  String toString() => 'SplashStartState';
}

class SplashNotLoggedInState extends SplashState {
  @override
  String toString() => 'SplashNotLoggedInState';
}

class SplashLoggedInState extends SplashState {
  final User user;

  SplashLoggedInState(this.user);

  @override
  String toString() => 'SplashLoggedInState';
}
