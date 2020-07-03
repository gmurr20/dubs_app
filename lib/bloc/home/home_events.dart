import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends HomeEvent {
  @override
  String toString() => 'StartEvent';
}

class AcceptEvent extends HomeEvent {
  String friendId;

  AcceptEvent(this.friendId);

  @override
  String toString() => 'AcceptEvent';
}

class DeclineEvent extends HomeEvent {
  String friendId;

  DeclineEvent(this.friendId);

  @override
  String toString() => 'DeclineEvent';
}
