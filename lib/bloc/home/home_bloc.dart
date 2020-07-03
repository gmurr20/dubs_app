import 'package:dubs_app/bloc/home/home_events.dart';
import 'package:dubs_app/bloc/home/home_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepo;

  final _logger = getLogger("HomeBloc");

  List<User> friends;
  List<UserSearchResult> friendRequests;

  HomeBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  HomeState get initialState => HomeStartState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    _logger.v("mapEventToState- entering");
    if (event is StartEvent) {
      yield* mapStartEventToState(event);
    } else if (event is AcceptEvent) {
      yield* mapAcceptEventToState(event);
    } else if (event is DeclineEvent) {
      yield* mapDeclineEventToState(event);
    }
  }

  Stream<HomeState> mapStartEventToState(StartEvent event) async* {
    _logger.v("mapStartEventToState- entering");
    yield ProcessingState(friendRequests, friends);
    try {
      friendRequests = await _userRepo
          .searchForFriendRequests(UserRelationshipState.INCOMING_INVITE);
    } catch (e) {
      _logger.e("mapStartEventToState- failed to fetch friend requests");
      yield ErrorState(friendRequests, friends, "Network error");
      return;
    }

    //TODO: get friends

    yield ResultsState(friendRequests, friends);
  }

  Stream<HomeState> mapAcceptEventToState(AcceptEvent event) async* {
    _logger.v("mapAcceptEventToState- entering");
    yield ProcessingState(friendRequests, friends);
    try {
      await _userRepo.acceptFriendRequest(event.friendId);
    } catch (e) {
      _logger.e("mapAcceptEventToState- failed to accept friend request");
      yield ErrorState(friendRequests, friends, "Network error");
      return;
    }

    for (int i = 0; i < friendRequests.length; i++) {
      if (friendRequests[i].userId == event.friendId) {
        friendRequests.removeAt(i);
        break;
      }
    }

    //TODO: refresh friends

    yield ResultsState(friendRequests, friends);
  }

  Stream<HomeState> mapDeclineEventToState(DeclineEvent event) async* {
    _logger.v("mapDeclineEventToState- entering");
    yield ProcessingState(friendRequests, friends);
    try {
      await _userRepo.declineFriendRequest(event.friendId);
    } catch (e) {
      _logger.e("mapDeclineEventToState- failed to decline friend request");
      yield ErrorState(friendRequests, friends, "Network error");
      return;
    }

    for (int i = 0; i < friendRequests.length; i++) {
      if (friendRequests[i].userId == event.friendId) {
        friendRequests.removeAt(i);
        break;
      }
    }

    yield ResultsState(friendRequests, friends);
  }
}
