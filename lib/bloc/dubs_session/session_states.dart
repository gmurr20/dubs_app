import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SessionState extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CountState extends SessionState {
  int wcount;
  int lcount;
  CountState(this.wcount, this.lcount);

  @override
  String toString() => 'CountState';
}

// This is some BS where the state always has to change
class TempAnimationState extends SessionState {
  // int count;
  int wcount;
  int lcount;
  CountState state;

  TempAnimationState(this.state);

  @override
  String toString() => 'TempAnimationState';
}

class SessionTimerState extends SessionState {
  bool sessionOngoing;
  bool sessionPaused;
  bool sessionCompleted;
  String elapsedTime;
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  SessionTimerState(this.sessionOngoing, this.sessionPaused,
      this.sessionCompleted, this.elapsedTime);
  @override
  String toString() => 'SessionTimerState';
}
