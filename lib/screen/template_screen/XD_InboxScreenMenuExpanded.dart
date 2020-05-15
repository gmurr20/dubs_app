import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import './XD_MenuButtonExpanded.dart';

class XD_InboxScreenMenuExpanded extends StatelessWidget {
  XD_InboxScreenMenuExpanded({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(1.0, 0.0),
            child:
                // Adobe XD layer: 'Menu Button Expanded' (component)
                XD_MenuButtonExpanded(),
          ),
        ],
      ),
    );
  }
}
