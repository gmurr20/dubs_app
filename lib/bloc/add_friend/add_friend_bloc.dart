import 'package:dubs_app/bloc/add_friend/add_friend_events.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_state.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  final UserRepository _userRepo;

  final int PAGINATE_SEARCH_LENGTH = 10;
  String lastSearchName = "";

  // cache the results for pagination
  List<UserSearchResult> searchResults = List<UserSearchResult>();
  String lastSearchElement;

  final _logger = getLogger("AddFriendBloc");

  AddFriendBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  AddFriendState get initialState => StartingState();

  @override
  Stream<AddFriendState> mapEventToState(AddFriendEvent event) async* {
    _logger.v("mapEventToState- entering");
    if (event is SearchEvent) {
      yield* _handleSearchEvent(event);
      return;
    } else if (event is PaginateSearchEvent) {
      yield* _handlePaginateEvent(event);
      return;
    } else if (event is SendFriendRequestEvent) {
      yield* _handleSendFriendRequestEvent(event);
      return;
    } else if (event is AcceptFriendRequestEvent) {
      yield* _handleAcceptFriendRequestEvent(event);
      return;
    } else if (event is DeclineFriendRequestEvent) {
      yield* _handleDeclineFriendRequestEvent(event);
      return;
    }
  }

  Stream<AddFriendState> _handleSearchEvent(SearchEvent event) async* {
    searchResults.clear();
    yield SearchingState(searchResults);
    // Call to search
    _logger
        .v("_handleSearchEvent- searching for username ${event.searchString}");
    try {
      searchResults = await _userRepo.searchForUsers(
          event.searchString, PAGINATE_SEARCH_LENGTH, null);
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(searchResults, e.toString());
      return;
    }

    _updateLastSearchName();

    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(searchResults);
  }

  Stream<AddFriendState> _handlePaginateEvent(
      PaginateSearchEvent event) async* {
    yield SearchingState(searchResults);
    // Call to search
    _logger.v(
        "_handleSearchEvent- searching for username ${event.searchString} and last search name ${lastSearchName}");
    try {
      searchResults.addAll(await _userRepo.searchForUsers(
          event.searchString, PAGINATE_SEARCH_LENGTH, lastSearchName));
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(searchResults, e.toString());
      return;
    }

    _updateLastSearchName();

    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(searchResults);
  }

  Stream<AddFriendState> _handleSendFriendRequestEvent(
      SendFriendRequestEvent event) async* {
    _logger
        .v("_handleSendFriendRequestEvent- friending user ${event.friendId}");
    yield SearchingState(searchResults);
    try {
      await _userRepo.sendFriendRequest(event.friendId);
    } catch (e) {
      _logger.w(
          "_handleSendFriendRequestEvent- error while sending friend request ${e.toString()}");
      yield ErrorState(searchResults, e.toString());
      return;
    }

    for (int i = 0; i < searchResults.length; i++) {
      if (searchResults[i].userId == event.friendId) {
        _logger.v(
            "_handleSendFriendRequestEvent- found friend and changing status");
        searchResults[i].state = UserRelationshipState.OUTSTANDING_INVITE;
        break;
      }
    }
    _logger.v("_handleSendFriendRequestEvent- done");
    yield ResultsState(searchResults);
  }

  Stream<AddFriendState> _handleAcceptFriendRequestEvent(
      AcceptFriendRequestEvent event) async* {
    _logger.v(
        "_handleAcceptFriendRequestEvent- accepting friend request for user ${event.userid}");
    yield SearchingState(searchResults);
    try {
      await _userRepo.acceptFriendRequest(event.userid);
    } catch (e) {
      _logger.w(
          "_handleAcceptFriendRequestEvent- error while accepting friend request ${e.toString()}");
      yield ErrorState(searchResults, e.toString());
      return;
    }

    for (int i = 0; i < searchResults.length; i++) {
      if (searchResults[i].userId == event.userid) {
        _logger.v(
            "_handleAcceptFriendRequestEvent- found friend and changing status");
        searchResults[i].state = UserRelationshipState.FRIENDS;
        break;
      }
    }
    _logger.v("_handleAcceptFriendRequestEvent- done");
    yield ResultsState(searchResults);
  }

  Stream<AddFriendState> _handleDeclineFriendRequestEvent(
      DeclineFriendRequestEvent event) async* {
    _logger.v(
        "_handleDeclineFriendRequestEvent- declining friend request for user ${event.userid}");
    yield SearchingState(searchResults);
    try {
      await _userRepo.declineFriendRequest(event.userid);
    } catch (e) {
      _logger.w(
          "_handleDeclineFriendRequestEvent- error while declining friend request ${e.toString()}");
      yield ErrorState(searchResults, e.toString());
      return;
    }

    for (int i = 0; i < searchResults.length; i++) {
      if (searchResults[i].userId == event.userid) {
        _logger.v(
            "_handleDeclineFriendRequestEvent- found friend and changing status");
        searchResults[i].state = UserRelationshipState.NOT_FRIENDS;
        break;
      }
    }
    _logger.v("_handleDeclineFriendRequestEvent- done");
    yield ResultsState(searchResults);
  }

  void _updateLastSearchName() {
    if (searchResults.isNotEmpty) {
      lastSearchName = searchResults[searchResults.length - 1].username;
    }
  }
}
