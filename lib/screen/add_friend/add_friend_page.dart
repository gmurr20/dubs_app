import 'dart:async';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_bloc.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_events.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_state.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendPage extends StatefulWidget {
  final UserRepository userRepository;
  final User user;

  AddFriendPage({Key key, @required this.userRepository, @required this.user})
      : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  AddFriendBloc _bloc;
  AddFriendState _pageState;
  final _logger = getLogger("AddFriendPage");

  final _searchController = TextEditingController();

  UserRepository get _userRepository => widget.userRepository;

  User get _currentuser => widget.user;

  @override
  void initState() {
    _bloc = AddFriendBloc(userRepo: _userRepository);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _search(String searchRes) {
    _logger.v("search- search ${_searchController.text}");
    _bloc.add(SearchEvent(searchRes));
  }

  void _leavePage() {
    _logger.v("_leavePage- entering");
    Navigator.of(context).pushNamed(homeRoute, arguments: _currentuser);
  }

  bool _onScroll(ScrollNotification scrollInfo) {
    _logger.v("onScroll- entered with ${_searchController.text}");
    if (_pageState is ResultsState &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _logger.v("onScroll- searching ${_searchController.text}");
      _bloc.add(PaginateSearchEvent(_searchController.text));
      return true;
    }
    return false;
  }

  void _sendFriendRequest(String friendId) {
    _logger.v("_sendFriendRequest- entered with friend id ${friendId}");
    _bloc.add(SendFriendRequestEvent(friendId));
  }

  Widget _buildSearchResults(AddFriendState state) {
    List<UserSearchResult> searchResults;
    if (state is ResultsState) {
      ResultsState resState = state;
      searchResults = resState.searchResults;
    } else if (state is SearchingState) {
      SearchingState searchState = state;
      searchResults = searchState.searchResults;
    } else {
      return Container();
    }
    _logger.v("_buildSearchResults- got ${searchResults.length} results");
    if (searchResults.isEmpty && state is ResultsState) {
      return Container(
        margin: EdgeInsetsDirectional.only(top: 50),
        child: Text(
          "No users found",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView.separated(
          itemCount: searchResults.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemBuilder: (context, index) {
            Widget trailingWidget;
            switch (searchResults[index].state) {
              case UserRelationshipState.FRIENDS:
                trailingWidget = Icon(Icons.people);
                break;
              case UserRelationshipState.INCOMING_INVITE:
                trailingWidget =
                    RaisedButton(onPressed: null, child: Text("Accept"));
                break;
              case UserRelationshipState.OUTSTANDING_INVITE:
                trailingWidget = Container(
                    width: 110,
                    child: Row(children: <Widget>[
                      Text("Request sent"),
                      Icon(Icons.check, color: Colors.green)
                    ]));
                break;
              case UserRelationshipState.NOT_FRIENDS:
                trailingWidget = IconButton(
                    icon: Icon(Icons.person_add),
                    onPressed: () =>
                        _sendFriendRequest(searchResults[index].userId));
                break;
            }
            return ListTile(
                title: Text(searchResults[index].username,
                    style: TextStyle(color: Colors.black)),
                trailing: trailingWidget);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        AddFriendState state,
      ) {
        _pageState = state;
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            AddFriendState state,
          ) {
            return Scaffold(
                body: Column(children: [
              // this close button will give the user an escape hatch
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  padding: spacer.top.lg + spacer.left.md,
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: _leavePage,
                ),
              ),
              TextFormField(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Search",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onFieldSubmitted: _search,
                  controller: _searchController),
              _buildSearchResults(state)
            ]));
          }),
    );
  }
}
