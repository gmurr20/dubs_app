import 'dart:async';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_bloc.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_events.dart';
import 'package:dubs_app/bloc/add_friend/add_friend_state.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendPage extends StatefulWidget {
  final UserRepository userRepository;

  AddFriendPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  AddFriendBloc _bloc;
  final _logger = getLogger("AddFriendPage");

  final _searchController = TextEditingController();

  UserRepository get _userRepository => widget.userRepository;

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
    _bloc.add(SearchEvent(searchRes));
  }

  Widget _buildSearchResults(AddFriendState state) {
    if (!(state is ResultsState)) {
      return Container();
    }
    ResultsState searchRes = state;
    _logger.v(
        "_buildSearchResults- got ${searchRes.searchResults.length} results");
    if (searchRes.searchResults.isEmpty) {
      return Container(
          height: 50, child: Text("No users found", style: darkprimaryPBold));
    }

    return ListView.builder(
      itemCount: searchRes.searchResults.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchRes.searchResults[index].username),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        AddFriendState state,
      ) {},
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            AddFriendState state,
          ) {
            return Scaffold(
                backgroundColor: DarwinRed,
                body: Column(children: [
                  TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: primaryPRegular,
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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
