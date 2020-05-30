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

class AcceptFriendRequestEvent extends AddFriendEvent {
  String userid;

  AcceptFriendRequestEvent(this.userid);

  @override
  String toString() => 'AcceptFriendRequestEvent';
}