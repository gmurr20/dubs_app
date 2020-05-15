import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class XD_HeaderHome extends StatelessWidget {
  XD_HeaderHome({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(174.5, 12.0),
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
          offset: Offset(0.0, -0.17),
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
    );
  }
}
