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

  void _acceptFriendRequest(String friendId) {
    _logger.v("_acceptFriendRequest- entering");
    _bloc.add(AcceptFriendRequestEvent(friendId));
  }

  void _declineFriendRequest(String friendId) {
    _logger.v("_declineFriendRequest- entering");
    _bloc.add(DeclineFriendRequestEvent(friendId));
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
        margin: spacer.top.xxs + spacer.left.xs + spacer.right.xs,
        child: Text(
          "No users found, please try a different username.",
          style: primaryPRegular,
        ),
      );
    }

    return Expanded(
      child: Column(children: [
        NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: ListView.separated(
            padding: spacer.top.xs + spacer.left.xxs + spacer.right.xxs,
            itemCount: searchResults.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
            ),
            itemBuilder: (context, index) {
              Widget trailingWidget;
              switch (searchResults[index].state) {
                case UserRelationshipState.FRIENDS:
                  trailingWidget = Container(
                    alignment: Alignment.centerRight,
                    width: 25,
                    child: Icon(Icons.people, color: Colors.white),
                  );
                  break;
                case UserRelationshipState.INCOMING_INVITE:
                  // TODO: this looks like shit
                  trailingWidget = Container(
                    alignment: Alignment.centerRight,
                    width: 180,
                    child: Row(children: <Widget>[
                      RaisedButton(
                          color: Colors.green[50],
                          onPressed: () =>
                              _acceptFriendRequest(searchResults[index].userId),
                          child: Text("Accept")),
                      RaisedButton(
                          color: Colors.red[50],
                          onPressed: () => _declineFriendRequest(
                              searchResults[index].userId),
                          child: Text("Decline"))
                    ]),
                  );
                  ;
                  break;
                case UserRelationshipState.OUTSTANDING_INVITE:
                  trailingWidget = Container(
                      alignment: Alignment.centerRight,
                      //  TODO: Need to fix this should not be a fixed width.
                      width: 120,
                      child: Row(children: <Widget>[
                        Text(
                          "Request sent",
                          style: primaryPRegular,
                        ),
                        Icon(Icons.check, color: Colors.green[900])
                      ]));
                  break;
                case UserRelationshipState.NOT_FRIENDS:
                  trailingWidget = Container(
                    alignment: Alignment.centerRight,
                    width: 25,
                    child: IconButton(
                      icon: Icon(Icons.person_add, color: Colors.white),
                      onPressed: () =>
                          _sendFriendRequest(searchResults[index].userId),
                    ),
                  );
                  break;
              }
              return ListTile(
                  title:
                      Text(searchResults[index].username, style: primaryPBold),
                  trailing: trailingWidget);
            },
          ),
        ),
      ]),
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
                backgroundColor: DarwinRed,
                body: Column(children: [
                  // this close button will give the user an escape hatch
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      padding: spacer.top.xl + spacer.left.sm,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 22,
                      onPressed: _leavePage,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.xs + spacer.bottom.xs,
                    margin: spacer.left.xs + spacer.right.xs,
                    child: Text(
                      'Add friends',
                      style: primaryH1Bold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.none + spacer.bottom.xs,
                    margin: spacer.left.xs + spacer.right.xs,
                    child: TextFormField(
                        style: primaryPRegular,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: primaryPRegular,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onFieldSubmitted: _search,
                        controller: _searchController),
                  ),
                  _buildSearchResults(state)
                ]));
          }),
    );
  }
}
