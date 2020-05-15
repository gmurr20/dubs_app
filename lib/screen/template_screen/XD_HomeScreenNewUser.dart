import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import './XD_HeaderHome.dart';
import './XD_ModalWelcome.dart';
import './XD_ModalInvite.dart';
import 'package:adobe_xd/page_link.dart';
import './XD_MenuButton.dart';
import './XD_InboxScreenMenuExpanded.dart';

class XD_HomeScreenNewUser extends StatelessWidget {
  XD_HomeScreenNewUser({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _currentWidth() {
      return MediaQuery.of(context).size.width;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(36.0, 53.0),
              child:
                  // Adobe XD layer: 'Header - Home' (component)
                  XD_HeaderHome(),
            ),
            Transform.translate(
              offset: Offset(13.0, 133.0),
              child:
                  // Adobe XD layer: 'Modal - Welcome' (component)
                  XD_ModalWelcome(),
            ),
            Transform.translate(
              offset: Offset(13.0, 308.0),
              child:
                  // Adobe XD layer: 'Modal - Invite' (component)
                  XD_ModalInvite(),
            ),
            Transform.translate(
              offset: Offset(280.0, 679.0),
              child: PageLink(
                links: [
                  PageLinkInfo(
                    transition: LinkTransition.Fade,
                    duration: 0.4,
                    ease: Curves.easeInOutExpo,
                    pageBuilder: () => XD_InboxScreenMenuExpanded(),
                  ),
                ],
                child:
                    // Adobe XD layer: 'Menu Button' (component)
                    XD_MenuButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
