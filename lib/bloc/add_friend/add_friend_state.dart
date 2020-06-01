import 'package:dubs_app/model/user_search_result.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddFriendState extends Equatable {
  @override
  List<Object> get props => [];
}

// results came back
class ResultsState extends AddFriendState {
  List<UserSearchResult> searchResults;

  ResultsState(this.searchResults);

  @override
  String toString() => 'ResultsState';
}

// searching for username
class SearchingState extends AddFriendState {
  List<UserSearchResult> searchResults;

  SearchingState(this.searchResults);
  @override
  String toString() => 'SearchingState';
}

class StartingState extends AddFriendState {
  @override
  String toString() => 'StartingState';
}

class ErrorState extends AddFriendState {
  String message;

  ErrorState(this.message);

  @override
  String toString() => 'ErrorState';
}
