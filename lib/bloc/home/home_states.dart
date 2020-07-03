import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeStartState extends HomeState {
  @override
  String toString() => 'HomeStartState';
}

// results came back
class ResultsState extends HomeState {
  List<UserSearchResult> friendRequests;
  List<User> friends;

  ResultsState(this.friendRequests, this.friends);

  @override
  String toString() => 'ResultsState';
}

class ProcessingState extends HomeState {
  List<UserSearchResult> friendRequests;
  List<User> friends;

  ProcessingState(this.friendRequests, this.friends);

  @override
  String toString() => 'ProcessingState';
}

class ErrorState extends HomeState {
  List<UserSearchResult> friendRequests;
  List<User> friends;
  String message;

  ErrorState(this.friendRequests, this.friends, this.message);

  @override
  String toString() => 'ErrorState';
}
