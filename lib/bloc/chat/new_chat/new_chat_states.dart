import 'dart:collection';

import 'package:dubs_app/model/new_chat_search_result.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewChatState extends Equatable {
  @override
  List<Object> get props => [];
}

// starting state
class StartingState extends NewChatState {
  @override
  String toString() => 'StartingState';
}

// results came back
class ResultsState extends NewChatState {
  LinkedHashSet<NewChatSearchResult> selected;

  LinkedHashSet<NewChatSearchResult> searchResults;

  ResultsState(this.selected, this.searchResults);

  @override
  String toString() => 'ResultsState';
}

// searching for more results
class SearchingState extends NewChatState {
  LinkedHashSet<NewChatSearchResult> selected;

  LinkedHashSet<NewChatSearchResult> searchResults;

  SearchingState(this.selected, this.searchResults);
  @override
  String toString() => 'SearchingState';
}

class ChatCreatedState extends NewChatState {
  String chatId;

  ChatCreatedState(this.chatId);

  @override
  String toString() => 'ChatCreatedState';
}

// an error occurred
class ErrorState extends NewChatState {
  LinkedHashSet<NewChatSearchResult> selected;
  LinkedHashSet<NewChatSearchResult> searchResults;
  String message;

  ErrorState(this.selected, this.searchResults, this.message);

  @override
  String toString() => 'ErrorState';
}
