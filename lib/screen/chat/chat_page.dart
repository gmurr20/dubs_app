import 'package:dubs_app/DesignSystem/dimensions.dart';
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

  @override
  Widget build(BuildContext context) {
    List<ChatSearchResult> chats = List<ChatSearchResult>();
    chats.add(ChatSearchResult("G", "Gmilli20", "Dubs!", "1:01pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(
        ChatSearchResult("S", "SpookyCactus151", "No dubs.", "12:56pm", ""));
    return Column(children: [
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
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Text(chats[index].iconInitials),
                      ),
                      Text(chats[index].chatName)
                    ],
                  ),
                ),
                trailing: Text(chats[index].lastMessageTimestamp),
                contentPadding: spacer.top.xxs +
                    spacer.bottom.xxs +
                    spacer.left.xs +
                    spacer.right.xxs,
              ),
            );
          },
        ),
      ),
    ]);
  }
}
