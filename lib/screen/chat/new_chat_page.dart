import 'dart:collection';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/chat/new_chat/new_chat_bloc.dart';
import 'package:dubs_app/bloc/chat/new_chat/new_chat_events.dart';
import 'package:dubs_app/bloc/chat/new_chat/new_chat_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/new_chat_search_result.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewChatPage extends StatefulWidget {
  final UserRepository userRepository;
  final User user;

  NewChatPage({Key key, @required this.userRepository, @required this.user})
      : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  NewChatBloc _bloc;
  NewChatState _pageState;
  final _logger = getLogger("_NewChatPageState");

  final _searchController = TextEditingController();

  UserRepository get _userRepository => widget.userRepository;

  User get _currentuser => widget.user;

  @override
  void initState() {
    _bloc = NewChatBloc(userRepo: _userRepository);
    _bloc.add(FindAllFriendsEvent());
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

  Widget _buildSelected(NewChatState state) {
    LinkedHashSet<NewChatSearchResult> selected;
    if (state is ResultsState) {
      ResultsState resState = state;
      selected = resState.selected;
    } else if (state is SearchingState) {
      SearchingState searchState = state;
      selected = searchState.selected;
    } else if (state is ErrorState) {
      ErrorState errorState = state;
      selected = errorState.selected;
      _logger.e("_buildSelected- error here ${errorState.message}");
    } else {
      return Container();
    }
    String startChatText = "";
    for (int i = 0; i < selected.length; i++) {
      startChatText += selected.elementAt(i).username;
      // TODO: Might need to rethink this because it would be good to have each selected user seperate to remove them.
      if (i < selected.length - 1) {
        startChatText += ", ";
      }
    }
    return Container();
    // return FlatButton(
    //     padding: spacer.all.none + spacer.right.xs,
    //     color: Colors.grey[100],
    //     splashColor: Colors.grey,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(100.0),
    //     ),
    //     onPressed: () {},
    //     child: Wrap(
    //         // alignment: WrapAlignment.center,
    //         crossAxisAlignment: WrapCrossAlignment.center,
    //         children: <Widget>[
    //           IconButton(
    //             alignment: Alignment.center,
    //             icon: Icon(
    //               Icons.people,
    //               color: Colors.black,
    //               size: 20,
    //             ),
    //             tooltip: 'Friends',
    //             enableFeedback: true,
    //             color: Colors.grey[300],
    //             onPressed: () {},
    //           ),
    //           Container(child: Text(startChatText))
    //         ]));
  }

  Widget _buildSearchResults(NewChatState state) {
    LinkedHashSet<NewChatSearchResult> searchResults;
    if (state is ResultsState) {
      ResultsState resState = state;
      searchResults = resState.searchResults;
    } else if (state is SearchingState) {
      SearchingState searchState = state;
      searchResults = searchState.searchResults;
    } else if (state is ErrorState) {
      ErrorState errorState = state;
      searchResults = errorState.searchResults;
      _logger.e("_buildSearchResults- error here ${errorState.message}");
    } else {
      return Container();
    }
    _logger.v("_buildSearchResults- got ${searchResults.length} results");
    if (searchResults.length == 0) {
      return Container(
        margin: spacer.top.xxs + spacer.left.xs + spacer.right.xs,
        child: Text(
          "No friends found, please try a different username.",
          style: primaryPRegular,
        ),
      );
    }

    return Column(children: [
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: SingleChildScrollView(
          child: ListView.builder(
              padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
              itemCount: searchResults.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NewChatSearchResult searchRes = searchResults.elementAt(index);
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(searchRes.username, style: darkprimaryPBold),
                    trailing: Padding(
                      padding: spacer.right.sm,
                      child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularCheckBox(
                              activeColor: Colors.black,
                              value: searchRes.isSelected,
                              onChanged: (bool value) {
                                _bloc.add(SelectChangeEvent(searchRes, value));
                              })),
                    ),
                    contentPadding: spacer.top.xxs +
                        spacer.bottom.xxs +
                        spacer.left.xs +
                        spacer.right.xxs,
                  ),
                );
              }),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        NewChatState state,
      ) {
        _pageState = state;
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            NewChatState state,
          ) {
            return Column(children: [
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.none,
                margin: spacer.left.xs + spacer.right.xs,
                child: Stack(children: [
                  Container(
                    padding: spacer.top.xs + spacer.bottom.xs,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: spacer.top.xxs,
                      margin: spacer.left.none,
                      child: Text(
                        "Choose Friends",
                        style: darkPrimaryH1Bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: spacer.top.xs + spacer.bottom.xs,
                    margin: spacer.right.none,
                    child: Container(
                      width: 55,
                      child: FlatButton(
                        padding: spacer.right.none,
                        color: DarwinRed,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        onPressed: () {},
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text(
                              'Done',
                              // textAlign: TextAlign.center,
                              style: primaryPBoldSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.none + spacer.bottom.xs,
                margin: spacer.left.xs + spacer.right.xs,
                child: CupertinoTextField(
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      ),
                    ),
                    prefixMode: OverlayVisibilityMode.always,
                    obscureText: false,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 3,
                            color: Colors.grey[400])
                      ],
                    ),
                    enableInteractiveSelection: true,
                    style: darkprimaryPRegular,
                    cursorColor: Colors.black,
                    placeholder: 'Search Friends',
                    onSubmitted: _search,
                    autocorrect: true,
                    autofocus: false,
                    showCursor: true,
                    enableSuggestions: true,
                    padding: spacer.all.xxs,
                    controller: _searchController),
              ),
              _buildSelected(state),
              _buildSearchResults(state),
            ]);
          }),
    );
  }
}
