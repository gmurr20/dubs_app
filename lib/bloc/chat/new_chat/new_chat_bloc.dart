import 'dart:collection';

import 'package:dubs_app/bloc/chat/new_chat/new_chat_events.dart';
import 'package:dubs_app/bloc/chat/new_chat/new_chat_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/new_chat_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final UserRepository _userRepo;

  final int PAGINATE_SEARCH_LENGTH = 10;
  String lastSearchName = "";

  // cache the results for pagination
  LinkedHashSet<NewChatSearchResult> selected =
      LinkedHashSet<NewChatSearchResult>();
  LinkedHashSet<NewChatSearchResult> searchResults =
      LinkedHashSet<NewChatSearchResult>();

  String lastSearchElement;

  final _logger = getLogger("NewChatBloc");

  NewChatBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  NewChatState get initialState => StartingState();

  @override
  Stream<NewChatState> mapEventToState(NewChatEvent event) async* {
    _logger.v("mapEventToState- entering");
    if (event is SearchEvent) {
      yield* _handleSearchEvent(event);
      return;
    } else if (event is PaginateSearchEvent) {
      yield* _handlePaginateEvent(event);
      return;
    } else if (event is SelectChangeEvent) {
      yield* _handleAddToChatEvent(event);
      return;
    } else if (event is FindAllFriendsEvent) {
      yield* _handleFindAllFriendsEvent(event);
      return;
    } else if (event is StartChatEvent) {
      yield* _handleStartChatEvent(event);
      return;
    }
  }

  Stream<NewChatState> _handleSearchEvent(SearchEvent event) async* {
    yield SearchingState(selected, searchResults);
    searchResults.clear();
    // Call to search
    _logger
        .v("_handleSearchEvent- searching for friends ${event.searchString}");
    try {
      searchResults = await _userRepo.searchForFriends(
          event.searchString, PAGINATE_SEARCH_LENGTH, null);
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(selected, searchResults, e.toString());
    }

    _updateLastSearchName();

    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(selected, searchResults);
  }

  Stream<NewChatState> _handleFindAllFriendsEvent(
      FindAllFriendsEvent event) async* {
    yield SearchingState(selected, searchResults);
    searchResults.clear();
    // Call to search
    _logger.v("_handleFindAllFriendsEvent- grabbing all friends");
    try {
      searchResults =
          await _userRepo.searchForFriends(null, PAGINATE_SEARCH_LENGTH, null);
    } catch (e) {
      _logger.i(
          "_handleFindAllFriendsEvent- error while searching for all friends: ${e.toString()}");
      yield ErrorState(selected, searchResults, e.toString());
    }

    _updateLastSearchName();

    _logger
        .v("_handleFindAllFriendsEvent- found ${searchResults.length} results");
    yield ResultsState(selected, searchResults);
  }

  Stream<NewChatState> _handlePaginateEvent(PaginateSearchEvent event) async* {
    yield SearchingState(selected, searchResults);
    // Call to search
    _logger.v(
        "_handleSearchEvent- searching for username ${event.searchString} and last search name ${lastSearchName}");
    try {
      searchResults.addAll(await _userRepo.searchForFriends(
          event.searchString, PAGINATE_SEARCH_LENGTH, lastSearchName));
    } catch (e) {
      _logger.i(
          "_handleSearchEvent- error while searching for username: ${e.toString()}");
      yield ErrorState(selected, searchResults, e.toString());
      return;
    }

    _updateLastSearchName();

    _logger.v("_handleSearchEvent- found ${searchResults.length} results");
    yield ResultsState(selected, searchResults);
  }

  Stream<NewChatState> _handleAddToChatEvent(SelectChangeEvent event) async* {
    yield SearchingState(selected, searchResults);

    if (event.newSelectValue && !selected.contains(event.personToAdd)) {
      selected.add(event.personToAdd);
    } else {
      selected.remove(event.personToAdd);
    }

    searchResults.lookup(event.personToAdd).isSelected = event.newSelectValue;

    yield ResultsState(selected, searchResults);
  }

  Stream<NewChatState> _handleStartChatEvent(StartChatEvent event) async* {
    yield SearchingState(selected, searchResults);

    List<String> users = List<String>();
    for (int i = 0; i < selected.length; i++) {
      users.add(selected.elementAt(i).userId);
    }

    String chatId;
    try {
      chatId = await _userRepo.createChat(users);
    } catch (e) {
      _logger.e(
          "_handleStartChatEvent- Failed to create chat with error ${e.toString()}");
      yield ErrorState(selected, searchResults, e.toString());
      return;
    }

    yield ChatCreatedState(chatId);
  }

  void _updateLastSearchName() {
    if (searchResults.isNotEmpty) {
      lastSearchName =
          searchResults.elementAt(searchResults.length - 1).username;
    }

    // update the selected
    for (int i = 0; i < selected.length; i++) {
      if (searchResults.contains(selected.elementAt(i))) {
        searchResults.lookup(selected.elementAt(i)).isSelected = true;
      }
    }
  }
}
