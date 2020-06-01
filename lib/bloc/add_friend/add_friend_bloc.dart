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
    }
  }

  Stream<AddFriendState> _handleSearchEvent(SearchEvent event) async* {
    searchResults.clear();
    yield SearchingState(searchResults);
    // Call to search
    _logger.v("_handleSearchEvent- searching for username {$event}");
    try {
      searchResults = await _userRepo.searchForFriends(
          event.searchString, PAGINATE_SEARCH_LENGTH, null);
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(e.toString());
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
      searchResults.addAll(await _userRepo.searchForFriends(
          event.searchString, PAGINATE_SEARCH_LENGTH, lastSearchName));
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(e.toString());
      return;
    }

    _updateLastSearchName();

    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(searchResults);
  }

  void _updateLastSearchName() {
    if (searchResults.isNotEmpty) {
      lastSearchName = searchResults[searchResults.length - 1].username;
    }
  }
}
