import 'dart:collection';

import 'package:bubble/bubble.dart';
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
import 'package:dubs_app/screen/chat/new_chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ActiveChatPage extends StatefulWidget {
  final UserRepository userRepository;
  final User user;

  ActiveChatPage({Key key, @required this.userRepository, @required this.user})
      : super(key: key);

  @override
  State<ActiveChatPage> createState() => _ActiveChatPageState();
}

class _ActiveChatPageState extends State<ActiveChatPage> {
  NewChatBloc _bloc;
  NewChatState _pageState;
  final _logger = getLogger("_ActiveChatPageState");

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

  void _leavePage() {
    _logger.v("_leavePage- entering");
    Navigator.of(context).pop();
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
  }

  @override
  Widget build(BuildContext context) {
    PanelController _pc = PanelController();
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.grey[200],
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: DarwinRed,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    final size = MediaQuery.of(context).size;
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
            return Scaffold(
              resizeToAvoidBottomInset: true,
              resizeToAvoidBottomPadding: true,
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.xl + spacer.left.sm,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      iconSize: 22,
                      onPressed: _leavePage,
                    ),
                  ),
                  Container(
                    height: size.height - 96,
                    // margin: spacer.bottom.md,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: ListView(
                            padding: EdgeInsets.all(8.0),
                            children: [
                              Bubble(
                                alignment: Alignment.center,
                                color: Colors.grey[200],
                                elevation: 1 * px,
                                margin: BubbleEdges.only(top: 8.0),
                                child:
                                    Text('TODAY', style: darkprimaryPBoldSmall),
                              ),
                              Bubble(
                                style: styleSomebody,
                                child: Text(
                                  'Hi Snoop, I\'m dave very nice to meet.',
                                  style: darkprimaryPRegular,
                                ),
                              ),
                              Bubble(
                                style: styleMe,
                                child: Text(
                                  'Whats\'up?',
                                  style: primaryPRegular,
                                ),
                              ),
                              Bubble(
                                style: styleSomebody,
                                child:
                                    Text('Dubs?', style: darkprimaryPRegular),
                              ),
                              Bubble(
                                style: styleMe,
                                child: Text('Dubs!', style: primaryPRegular),
                              ),
                              Bubble(
                                style: styleMe,
                                nip: BubbleNip.no,
                                margin: BubbleEdges.only(top: 2.0),
                                child: Text('Let\'s hop on in 15.',
                                    style: primaryPRegular),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: spacer.bottom.md,
                              child: Wrap(children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: spacer.left.xs + spacer.right.xs,
                                  height: 60,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            spacer.right.xxs + spacer.left.xxs,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text('Dubs?',
                                              style: primaryPBold),
                                          color: DarwinRed,
                                          onPressed: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            spacer.right.xxs + spacer.left.xxs,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text('Dubs!',
                                              style: primaryPBold),
                                          color: DarwinRed,
                                          onPressed: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            spacer.right.xxs + spacer.left.xxs,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text('No Dubs',
                                              style: primaryPBold),
                                          color: DarwinRed,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // alignment: Alignment.bottomCenter,
                                  margin: spacer.left.xs + spacer.right.xs,
                                  height: 80,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  blurRadius: 5,
                                                  color: Colors.grey)
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.face),
                                                  onPressed: () {}),
                                              Expanded(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText: "Aa",
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                              Padding(
                                                padding: spacer.right.xxs +
                                                    spacer.left.xxs,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text('Go',
                                                      style: primaryPBold),
                                                  color: DarwinRed,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
