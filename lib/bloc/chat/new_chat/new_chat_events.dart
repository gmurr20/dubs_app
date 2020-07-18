import 'package:dubs_app/model/new_chat_search_result.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEvent extends NewChatEvent {
  String searchString;

  SearchEvent(this.searchString);

  @override
  String toString() => 'AddFriendEvent';
}

class PaginateSearchEvent extends NewChatEvent {
  String searchString;

  PaginateSearchEvent(this.searchString);

  @override
  String toString() => 'PaginateSearchEvent';
}

class AddToChatEvent extends NewChatEvent {
  NewChatSearchResult personToAdd;

  AddToChatEvent(this.personToAdd);

  @override
  String toString() => 'AddToChatEvent';
}

class StartChatEvent extends NewChatEvent {
  @override
  String toString() => 'StartChatEvent';
}
