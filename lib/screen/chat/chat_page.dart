import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/Widgets/WaveWidget.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/chat_search_result.dart';
import 'package:dubs_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  PanelController _pc = PanelController();

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

  void _onNewMessagePressed() {
    _pc.open();
  }

  void _search(String searchStr) {}

  // Builds a close button
  Widget buildCloseButton(BuildContext context) {
    return IconButton(
      alignment: Alignment.topLeft,
      padding: spacer.top.lg + spacer.left.md,
      icon: Icon(Icons.close),
      color: Colors.black,
      iconSize: 28,
      onPressed: () => _pc.close(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ChatSearchResult> chats = List<ChatSearchResult>();
    chats.add(ChatSearchResult("G", "Gmilli20", "Dubs!", "1:01pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));
    chats.add(ChatSearchResult("B", "Bmac2233", "Dubs?", "12:58pm", ""));

    chats.add(
        ChatSearchResult("S", "SpookyCactus151", "No dubs.", "12:56pm", ""));

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DarwinRed,
      body: Stack(children: [
        WaveWidget(
          size: size,
          yOffset: size.height / 4,
          color: const Color(0xfff2f2f2),
        ),
        SlidingUpPanel(
          // header: buildCloseButton(context),
          controller: _pc,
          backdropEnabled: true,
          margin: spacer.all.xs + spacer.top.xxl,
          backdropColor: DarwinWhite,
          backdropOpacity: .9,
          backdropTapClosesPanel: true,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height,
          borderRadius: BorderRadius.circular(20),
          panel: Column(
            children: [
              Container(
                margin: spacer.top.xxs,
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () => _pc.close(),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.none,
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
                    autofocus: false,
                    showCursor: true,
                    enableSuggestions: true,
                    padding: spacer.all.xxs,
                    controller: _searchController),
              ),
            ],
          ),
          body: Column(children: [
            //Header Modal
            Container(
              alignment: Alignment.topLeft,
              padding: spacer.top.xxl,
              margin: spacer.left.xs + spacer.right.xs,
              child: Stack(children: [
                Container(
                  padding: spacer.left.xs + spacer.top.xs + spacer.bottom.xs,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.xxs,
                    margin: spacer.left.none,
                    child: Text(
                      "Message",
                      style: primaryH1Bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: spacer.top.xs + spacer.bottom.xs,
                  margin: spacer.right.md,
                  child: ClipOval(
                    child: Material(
                      borderOnForeground: true,
                      color: Colors.white,
                      child: InkWell(
                        child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.edit,
                              color: DarwinRed,
                            )),
                        onTap: _onNewMessagePressed,
                      ),
                    ),
                  ),
                ),
              ]),
            ),

            Container(
              alignment: Alignment.topLeft,
              padding: spacer.top.xxs + spacer.bottom.xxs,
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
              child: Container(
                height: MediaQuery.of(context).size.height - 260,
                child: ListView.builder(
                  padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
                  itemCount: chats.length,
                  addAutomaticKeepAlives: true,
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
                                  shape: BoxShape.circle, color: DarwinRed),
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
            ),
          ]),
        ),
      ]),
    );
  }
}
