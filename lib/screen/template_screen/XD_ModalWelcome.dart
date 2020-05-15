import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class XD_ModalWelcome extends StatelessWidget {
  XD_ModalWelcome({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
        Transform.translate(
          offset: Offset(91.5, 113.0),
          child:
              // Adobe XD layer: 'Action Button' (group)
              Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(-0.5, -4.0),
                child:
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
              ),
              Transform.translate(
                offset: Offset(-0.5, -4.0),
                child: Container(
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
          offset: Offset(22.0, 8.83),
          child: SizedBox(
            width: 303.0,
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
              textAlign: TextAlign.left,
            )),
          ),
        ),
        Transform.translate(
          offset: Offset(23.0, 54.67),
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
    );
  }
}
