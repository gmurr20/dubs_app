import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import './XD_InboxScreenMenuExpanded.dart';

class XD_InboxScreen extends StatelessWidget {
  XD_InboxScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _currentHeight() {
      return MediaQuery.of(context).size.height;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-22.0, -404.0),
            child:
                // Adobe XD layer: 'Body' (group)
                Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // Adobe XD layer: 'Greg's Message' (group)
                    Stack(
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(93.0, 558.33),
                          child:
                              // Adobe XD layer: 'Message Text' (text)
                              Text(
                            'DUBS? 5:35 PM',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: const Color(0x8a000000),
                              height: 1.4285714285714286,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(93.0, 535.0),
                          child:
                              // Adobe XD layer: 'Sender' (text)
                              Text(
                            'Greg Murray',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              color: const Color(0xde000000),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(52.0, 545.0),
                          child:
                              // Adobe XD layer: 'Contact Button' (group)
                              Stack(
                            children: <Widget>[
                              Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: const Color(0xffc2dbf4),
                                  border: Border.all(
                                      width: 0.25,
                                      color: const Color(0xff707070)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x1a000000),
                                        offset: Offset(5, 5),
                                        blurRadius: 15)
                                  ],
                                ),
                              ),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: const Color(0xffc2dbf4),
                                  border: Border.all(
                                      width: 0.25,
                                      color: const Color(0xff707070)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xcbffffff),
                                        offset: Offset(-5, -5),
                                        blurRadius: 15)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(291.0, 545.0),
                          child:
                              // Adobe XD layer: 'Reply Button' (group)
                              Stack(
                            children: <Widget>[
                              Container(
                                width: 76.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: const Color(0xffeaebf3),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x1a000000),
                                        offset: Offset(5, 5),
                                        blurRadius: 15)
                                  ],
                                ),
                              ),
                              Container(
                                width: 76.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: const Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xcbffffff),
                                        offset: Offset(-5, -5),
                                        blurRadius: 15)
                                  ],
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(14.0, 2.67),
                                child: SizedBox(
                                  width: 48.0,
                                  child: Text(
                                    'Reply',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.006559999942779541,
                                      fontWeight: FontWeight.w500,
                                      height: 1.375,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 53.0),
                      child:
                          // Adobe XD layer: 'Carolyn's Message' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(93.0, 558.33),
                            child:
                                // Adobe XD layer: 'Message Text' (text)
                                Text(
                              'DUBS! 5:35 PM',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0x8a000000),
                                height: 1.4285714285714286,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(93.0, 535.0),
                            child:
                                // Adobe XD layer: 'Sender' (text)
                                Text(
                              'Carolyn Meisles',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: const Color(0xde000000),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(52.0, 545.0),
                            child:
                                // Adobe XD layer: 'Contact Button' (group)
                                Stack(
                              children: <Widget>[
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: const Color(0xfff4c2c2),
                                    border: Border.all(
                                        width: 0.25,
                                        color: const Color(0xff707070)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x1a000000),
                                          offset: Offset(5, 5),
                                          blurRadius: 15)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: const Color(0xfff4c2c2),
                                    border: Border.all(
                                        width: 0.25,
                                        color: const Color(0xff707070)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xcbffffff),
                                          offset: Offset(-5, -5),
                                          blurRadius: 15)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(291.0, 545.0),
                            child:
                                // Adobe XD layer: 'Reply Button' (group)
                                Stack(
                              children: <Widget>[
                                Container(
                                  width: 76.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0xffeaebf3),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x1a000000),
                                          offset: Offset(5, 5),
                                          blurRadius: 15)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 76.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xcbffffff),
                                          offset: Offset(-5, -5),
                                          blurRadius: 15)
                                    ],
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(14.0, 2.67),
                                  child: SizedBox(
                                    width: 48.0,
                                    child: Text(
                                      'Reply',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        color: const Color(0xff000000),
                                        letterSpacing: -0.006559999942779541,
                                        fontWeight: FontWeight.w500,
                                        height: 1.375,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(-122.59, -2845.61),
            child:
                // Adobe XD layer: 'Header' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(333.09, 2910.61),
                  child:
                      // Adobe XD layer: 'New Message Button' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(-0.5, -4.0),
                        child:
                            // Adobe XD layer: 'BG Rectangle 1' (shape)
                            Container(
                          width: 139.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0xcbffffff),
                                  offset: Offset(-5, -5),
                                  blurRadius: 15)
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-0.5, -4.0),
                        child:
                            // Adobe XD layer: 'BG Rectangle 2' (shape)
                            Container(
                          width: 139.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x1a000000),
                                  offset: Offset(5, 5),
                                  blurRadius: 15)
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(8.5, -1.33),
                        child:
                            // Adobe XD layer: 'Button_Text' (text)
                            SizedBox(
                          width: 122.0,
                          child: Text(
                            'New Message',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              color: const Color(0xff000000),
                              letterSpacing: -0.006559999942779541,
                              fontWeight: FontWeight.w500,
                              height: 1.375,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(158.59, 2898.44),
                  child:
                      // Adobe XD layer: 'Header_text' (text)
                      Text(
                    'Inbox',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 34,
                      color: const Color(0xff000000),
                      letterSpacing: 0.136,
                      fontWeight: FontWeight.w700,
                      height: 1.2058823529411764,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(-38.59, -2473.61),
            child: PageLink(
              links: [
                PageLinkInfo(
                  trigger: LinkTrigger.Tap,
                  transition: LinkTransition.Fade,
                  duration: 0.4,
                  ease: Curves.easeInOutExpo,
                  pageBuilder: () => XD_InboxScreenMenuExpanded(),
                ),
              ],
              child:
                  // Adobe XD layer: 'Floating Menu Button' (group)
                  Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(329.09, 2919.61),
                    child:
                        // Adobe XD layer: 'Menu Button' (group)
                        Stack(
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(-21.5, -22.0),
                          child:
                              // Adobe XD layer: 'BG Rectangle 1' (shape)
                              Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: const Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xcbffffff),
                                    offset: Offset(-5, -5),
                                    blurRadius: 15)
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(-21.5, -22.0),
                          child:
                              // Adobe XD layer: 'BG Rectangle 2' (shape)
                              Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: const Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x1a000000),
                                    offset: Offset(5, 5),
                                    blurRadius: 15)
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(6.5, 6.0),
                          child:
                              // Adobe XD layer: 'menu-24px' (group)
                              SvgPicture.string(
                            _shapeSVG_b12404f3496241618b1949d637fc04a1,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _shapeSVG_b12404f3496241618b1949d637fc04a1 =
    '<svg viewBox="6.5 6.0 24.0 24.0" ><g transform="translate(6.5, 6.0)"><path  d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 3 18 L 21 18 L 21 16 L 3 16 L 3 18 Z M 3 13 L 21 13 L 21 11 L 3 11 L 3 13 Z M 3 6 L 3 8 L 21 8 L 21 6 L 3 6 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';
