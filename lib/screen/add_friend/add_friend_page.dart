import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_bloc.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_events.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_state.dart';
import 'package:dubs_app/component/user_search_result_builder.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:dubs_app/repository/user_repository.dart';
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
    Navigator.of(context).pop();
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

    return Column(children: [
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: buildSearchResults(searchResults, _acceptFriendRequest,
            _declineFriendRequest, _sendFriendRequest),
      ),
    ]);
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
                    padding: spacer.top.xl + spacer.left.sm,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 22,
                      onPressed: _leavePage,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.xxs + spacer.bottom.xs,
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
                    child: CupertinoTextField(
                        prefix: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                        prefixMode: OverlayVisibilityMode.always,
                        obscureText: false,
                        enableInteractiveSelection: true,
                        style: darkprimaryPRegular,
                        cursorColor: Colors.black,
                        placeholder: 'Search Username',
                        onSubmitted: _search,
                        autocorrect: true,
                        autofocus: true,
                        showCursor: true,
                        enableSuggestions: true,
                        padding: spacer.all.xxs,
                        controller: _searchController),
                  ),
                  _buildSearchResults(state),
                ]));
          }),
    );
  }
}
