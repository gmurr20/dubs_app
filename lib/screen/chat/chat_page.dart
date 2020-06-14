import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/chat_search_result.dart';
import 'package:dubs_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ChatPageInput {
  User user;

  ChatPageInput(this.user);
}

class ChatPage extends StatefulWidget {
  ChatPageInput input;

  ChatPage({PageStorageKey key, @required this.input}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Logger _logger = getLogger("ChatPage");

  TextEditingController _searchController = TextEditingController();

  User get _currentUser => widget.input.user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _onScroll(ScrollNotification scrollInfo) {
    _logger.v("onScroll- entered");
    return false;
  }

  void _search(String searchStr) {}

  @override
  Widget build(BuildContext context) {
    List<ChatSearchResult> chats = List<ChatSearchResult>();
    chats.add(ChatSearchResult("G", "Gmilli20", "Dubs!", "1:01pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(
        ChatSearchResult("S", "SpookyCactus151", "No dubs.", "12:56pm", ""));
    return Column(children: [
      Container(
        alignment: Alignment.center,
        child: Text(
          "Messages",
          style: TextStyle(fontSize: 30),
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
            placeholder: 'Search',
            onSubmitted: _search,
            autocorrect: true,
            autofocus: true,
            showCursor: true,
            enableSuggestions: true,
            padding: spacer.all.xxs,
            controller: _searchController),
      ),
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView.builder(
          padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
          itemCount: chats.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Container(
                width: 200,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          chats[index].iconInitials,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chats[index].chatName,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              chats[index].lastMessage,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              trailing: Text(chats[index].lastMessageTimestamp),
              contentPadding: spacer.top.xxs +
                  spacer.bottom.xxs +
                  spacer.left.xs +
                  spacer.right.xxs,
            ));
          },
        ),
      ),
    ]);
  }
}
