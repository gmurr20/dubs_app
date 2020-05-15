import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import './XD_InboxListView.dart';
import './XD_HeaderInbox.dart';
import './XD_MenuButton.dart';

class XD_InboxScreen extends StatelessWidget {
  XD_InboxScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(30.0, 135.0),
            child:
                // Adobe XD layer: 'InboxListView' (component)
                XD_InboxListView(),
          ),
          Transform.translate(
            offset: Offset(36.0, 53.0),
            child:
                // Adobe XD layer: 'Header - Inbox' (component)
                XD_HeaderInbox(),
          ),
          Transform.translate(
            offset: Offset(280.0, 679.0),
            child:
                // Adobe XD layer: 'Menu Button' (component)
                XD_MenuButton(),
          ),
        ],
      ),
    );
  }
}
