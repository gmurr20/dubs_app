import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddFriendEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEvent extends AddFriendEvent {
  String searchString;

  SearchEvent(this.searchString);

  @override
  String toString() => 'AddFriendEvent';
}

class PaginateSearchEvent extends AddFriendEvent {
  String searchString;

  PaginateSearchEvent(this.searchString);

  @override
  String toString() => 'PaginateSearchEvent';
}

class SendFriendRequestEvent extends AddFriendEvent {
  String friendId;

  SendFriendRequestEvent(this.friendId);

  @override
  String toString() => 'SendFriendRequestEvent';
}

class AcceptFriendRequestEvent extends AddFriendEvent {
  String userid;

  AcceptFriendRequestEvent(this.userid);

  @override
  String toString() => 'AcceptFriendRequestEvent';
}

class DeclineFriendRequestEvent extends AddFriendEvent {
  String userid;

  DeclineFriendRequestEvent(this.userid);

  @override
  String toString() => 'DeclineFriendRequestEvent';
}
