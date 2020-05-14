import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class XD_HomeScreenNewUser extends StatelessWidget {
  final VoidCallback MenuButtonTest;
  XD_HomeScreenNewUser({
    Key key,
    this.MenuButtonTest,
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
                    'Home',
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
            offset: Offset(-27.59, -2218.61),
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
                          _shapeSVG_b982bad2d8c3484a841b5249e3dfa775,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(307.58599853515625, 2897.6064453125),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child:
                          GestureDetector(onTap: () => MenuButtonTest?.call()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(-17.0, -346.32),
            child:
                // Adobe XD layer: 'Welcome Modal' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(30.0, 479.32),
                  child:
                      // Adobe XD layer: 'Modal BG' (group)
                      Stack(
                    children: <Widget>[
                      // Adobe XD layer: 'Rectangle 1' (shape)
                      Container(
                        width: 349.0,
                        height: 163.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xcbf4f4f4),
                                offset: Offset(-5, -5),
                                blurRadius: 15)
                          ],
                        ),
                      ),
                      Container(
                        width: 349.0,
                        height: 163.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1a000000),
                                offset: Offset(5, 5),
                                blurRadius: 15)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(121.5, 592.32),
                  child:
                      // Adobe XD layer: 'Add Friends Button' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(-0.5, -4.0),
                        child:
                            // Adobe XD layer: 'Add Friends Button' (group)
                            Stack(
                          children: <Widget>[
                            // Adobe XD layer: 'Rectangle 1' (shape)
                            Container(
                              width: 139.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: const Color(0xffffd1d1),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xcbffffff),
                                      offset: Offset(-5, -5),
                                      blurRadius: 15)
                                ],
                              ),
                            ),
                            Container(
                              width: 139.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: const Color(0xffffd1d1),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x1a000000),
                                      offset: Offset(5, 5),
                                      blurRadius: 15)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(17.5, -2.33),
                        child:
                            // Adobe XD layer: 'Add Friends' (text)
                            SizedBox(
                          width: 102.0,
                          child: Text(
                            'Add Friends',
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
                  offset: Offset(52.0, 488.15),
                  child: SizedBox(
                    width: 206.0,
                    height: 37.0,
                    child: SingleChildScrollView(
                        child: Text(
                      'Welcome, Brian!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        color: const Color(0xff000000),
                        letterSpacing: 0.112,
                        fontWeight: FontWeight.w500,
                        height: 1.4642857142857142,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Transform.translate(
                  offset: Offset(53.0, 533.98),
                  child: SizedBox(
                    width: 302.0,
                    height: 47.0,
                    child: SingleChildScrollView(
                        child: Text(
                      'Let’s get started by adding some of your friends.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xff000000),
                        letterSpacing: -0.006559999942779541,
                        fontWeight: FontWeight.w500,
                        height: 1.375,
                      ),
                      textAlign: TextAlign.left,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(-17.0, -171.32),
            child:
                // Adobe XD layer: 'Invite Friends Modal' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(30.0, 479.32),
                  child:
                      // Adobe XD layer: 'Modal BG' (group)
                      Stack(
                    children: <Widget>[
                      // Adobe XD layer: 'Rectangle 1' (shape)
                      Container(
                        width: 349.0,
                        height: 163.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xcbf4f4f4),
                                offset: Offset(-5, -5),
                                blurRadius: 15)
                          ],
                        ),
                      ),
                      Container(
                        width: 349.0,
                        height: 163.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1a000000),
                                offset: Offset(5, 5),
                                blurRadius: 15)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(121.5, 592.32),
                  child:
                      // Adobe XD layer: 'Add Friends Button' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(-0.5, -4.0),
                        child:
                            // Adobe XD layer: 'Add Friends Button' (group)
                            Stack(
                          children: <Widget>[
                            // Adobe XD layer: 'Rectangle 1' (shape)
                            Container(
                              width: 139.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: const Color(0xffcee3ff),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xcbffffff),
                                      offset: Offset(-5, -5),
                                      blurRadius: 15)
                                ],
                              ),
                            ),
                            Container(
                              width: 139.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: const Color(0xffcee3ff),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x1a000000),
                                      offset: Offset(5, 5),
                                      blurRadius: 15)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(11.5, -2.33),
                        child:
                            // Adobe XD layer: 'Add Friends' (text)
                            SizedBox(
                          width: 114.0,
                          child: Text(
                            'Invite Friends',
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
                  offset: Offset(52.0, 488.15),
                  child: SizedBox(
                    width: 218.0,
                    height: 37.0,
                    child: SingleChildScrollView(
                        child: Text(
                      'Invite your squad',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        color: const Color(0xff000000),
                        letterSpacing: 0.112,
                        fontWeight: FontWeight.w500,
                        height: 1.4642857142857142,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Transform.translate(
                  offset: Offset(53.0, 533.98),
                  child: SizedBox(
                    width: 302.0,
                    height: 47.0,
                    child: SingleChildScrollView(
                        child: Text(
                      'You can invite your friends to Dubs via Text or Email.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xff000000),
                        letterSpacing: -0.006559999942779541,
                        fontWeight: FontWeight.w500,
                        height: 1.375,
                      ),
                      textAlign: TextAlign.left,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _shapeSVG_b982bad2d8c3484a841b5249e3dfa775 =
    '<svg viewBox="6.5 6.0 24.0 24.0" ><g transform="translate(6.5, 6.0)"><path  d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 3 18 L 21 18 L 21 16 L 3 16 L 3 18 Z M 3 13 L 21 13 L 21 11 L 3 11 L 3 13 Z M 3 6 L 3 8 L 21 8 L 21 6 L 3 6 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';
