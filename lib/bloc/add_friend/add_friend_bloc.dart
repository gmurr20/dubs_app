import 'package:dubs_app/bloc/add_friend/add_friend_events.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_state.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  final UserRepository _userRepo;
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
    }
  }

  Stream<AddFriendState> _handleSearchEvent(SearchEvent event) async* {
    yield SearchingState();
    // Call to search
    _logger.v("_handleSearchEvent- searching for username {$event}");
    List<UserSearchResult> searchResults;
    try {
      searchResults = await _userRepo.searchForFriends(event.searchString);
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(e.toString());
      return;
    }
    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(searchResults);
  }
}
