import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SessionState extends Equatable {
  @override
  List<Object> get props => [];
  //int count;
}

// ignore: must_be_immutable
class CountState extends SessionState {
  // CountState countState = CountState(0);
  int count;
  CountState(this.count);

  @override
  String toString() => 'CountState';
}

// This is some BS where the state always has to change
class TempAnimationState extends SessionState {
  // int count;
  CountState state;
  int count;
  TempAnimationState(this.state);

  @override
  String toString() => 'TempAnimationState';
}
