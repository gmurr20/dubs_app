import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncrementWinEvent extends SessionEvent {
  int count;
  @override
  String toString() => 'IncrementWinEvent';
}

class DecrementWinEvent extends SessionEvent {
  @override
  String toString() => 'DecrementWinEvent';
}

class IncrementLossEvent extends SessionEvent {
  @override
  String toString() => 'IncrementLossEvent';
}

class DecrementLossEvent extends SessionEvent {
  @override
  String toString() => 'DecrementLossEvent';
}
