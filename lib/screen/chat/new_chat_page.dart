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
import 'package:dubs_app/router/router.dart';

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
    // String startChatText = "";
    // for (int i = 0; i < selected.length; i++) {
    //   startChatText += selected.elementAt(i).username;
    //   // TODO: Might need to rethink this because it would be good to have each selected user seperate to remove them.
    //   if (i < selected.length - 1) {
    //     startChatText += selected.elementAt(i).username;
    //   }
    // }

    if (selected.isEmpty) {
      return Container();
    }

    return Container(
      padding: spacer.left.xs,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
              Padding(
                padding: spacer.left.xxs,
                child: FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.black,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () {},
                    child: Wrap(
                        // alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: spacer.left.xs,
                              child: Text(
                                "Test",
                                style: primaryPBoldSmall,
                              )),
                          IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                        ])),
              ),
            ],
          ),
        ),
      ),
    );

    //Container(
    //   padding: spacer.top.xs + spacer.bottom.xs,
    //   child: Row(children: [
    //     NotificationListener<ScrollNotification>(
    //       onNotification: _onScroll,
    //       child: ListView.builder(
    //           padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
    //           itemCount: selected.length,
    //           scrollDirection: Axis.horizontal,
    //           shrinkWrap: true,
    //           itemBuilder: (context, index) {
    //             NewChatSearchResult selected;
    //             return Card(
    //               elevation: 2,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(35.0),
    //               ),
    //               child: Container(
    //                 child: ListTile(
    //                   title: Text(selected.username, style: darkprimaryPBold),
    //                   trailing: Padding(
    //                     padding: spacer.right.sm,
    //                     child: SizedBox(
    //                       width: 10,
    //                       height: 10,
    //                       child: IconButton(
    //                         padding: spacer.right.none,
    //                         alignment: Alignment.centerRight,
    //                         icon: Icon(
    //                           Icons.clear,
    //                           color: Colors.black,
    //                           size: 18,
    //                         ),
    //                         tooltip: 'Clear',
    //                         enableFeedback: true,
    //                         color: Colors.grey[300],
    //                         onPressed: () {},
    //                       ),
    //                       // CircularCheckBox(
    //                       //     activeColor: Colors.black,
    //                       //     value: selected.isSelected,
    //                       //     onChanged: (bool value) {
    //                       //       _bloc.add(SelectChangeEvent(selected, value));
    //                       //     })
    //                     ),
    //                   ),
    //                   contentPadding: spacer.top.xxs +
    //                       spacer.bottom.xxs +
    //                       spacer.left.xs +
    //                       spacer.right.xxs,
    //                 ),
    //               ),
    //             );
    //           }),
    //     ),
    //   ]),
    // );

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
    //           Container(padding: spacer.left.xs, child: Text(startChatText)),
    //           IconButton(
    //             padding: spacer.right.none,
    //             alignment: Alignment.centerRight,
    //             icon: Icon(
    //               Icons.clear,
    //               color: Colors.black,
    //               size: 18,
    //             ),
    //             tooltip: 'Clear',
    //             enableFeedback: true,
    //             color: Colors.grey[300],
    //             onPressed: () {},
    //           ),
    //         ]));
  }

  Widget _buildStartChatButton(NewChatState state) {
    LinkedHashSet<NewChatSearchResult> res;
    if (state is ResultsState) {
      ResultsState resState = state;
      res = resState.selected;
    } else if (state is SearchingState) {
      SearchingState searchState = state;
      res = searchState.selected;
    } else if (state is ErrorState) {
      ErrorState errorState = state;
      res = errorState.selected;
      _logger.e("_buildStartChatButton- error here ${errorState.message}");
    } else {
      return Container();
    }

    if (res.isEmpty) {
      return Container();
    }

    return Container(
      alignment: Alignment.centerRight,
      padding: spacer.top.xs + spacer.bottom.xs,
      margin: spacer.right.xs + spacer.left.xs,
      child: Container(
        width: 80,
        child: FlatButton(
          padding: spacer.right.none,
          color: Colors.black,
          splashColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          onPressed: () {
            _bloc.add(StartChatEvent());
          },
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                'Start Chat',
                // textAlign: TextAlign.center,
                style: primaryPBoldSmall,
              ),
            ],
          ),
        ),
      ),
    );
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
                  child: Container(
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
                                  _bloc
                                      .add(SelectChangeEvent(searchRes, value));
                                })),
                      ),
                      contentPadding: spacer.top.xxs +
                          spacer.bottom.xxs +
                          spacer.left.xs +
                          spacer.right.xxs,
                    ),
                  ),
                );
              }),
        ),
      ),
    ]);
  }

  Widget _buildSelectedResults(NewChatState state) {
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
      _logger.e("_buildSearchResults- error here ${errorState.message}");
    } else {
      return Container();
    }
    _logger.v("_buildSearchResults- got ${selected.length} results");
    if (selected.length == 0) {
      return Container();
    }

    return Row(children: [
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: SingleChildScrollView(
          child: ListView.builder(
              padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
              itemCount: selected.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NewChatSearchResult selected;
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
                    child: ListTile(
                      title: Text(selected.username, style: darkprimaryPBold),
                      trailing: Padding(
                        padding: spacer.right.sm,
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: IconButton(
                            padding: spacer.right.none,
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: 18,
                            ),
                            tooltip: 'Clear',
                            enableFeedback: true,
                            color: Colors.grey[300],
                            onPressed: () {},
                          ),
                          // CircularCheckBox(
                          //     activeColor: Colors.black,
                          //     value: selected.isSelected,
                          //     onChanged: (bool value) {
                          //       _bloc.add(SelectChangeEvent(selected, value));
                          //     })
                        ),
                      ),
                      contentPadding: spacer.top.xxs +
                          spacer.bottom.xxs +
                          spacer.left.xs +
                          spacer.right.xxs,
                    ),
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
        if (state is ChatCreatedState) {
          ChatCreatedState newChatState = state;
          _logger.v("Entering new chat with id ${newChatState.chatId}");
          Navigator.of(context)
              .pushNamed(activeChatRoute, arguments: _currentuser);
        }
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
                  _buildStartChatButton(state),
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
