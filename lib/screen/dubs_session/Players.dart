import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:flutter/material.dart';

class Players extends StatelessWidget {
  Players({
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
              height: 90.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xcbf4f4f4),
                    offset: Offset(-5, -5),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
            Container(
              width: 349.0,
              height: 90.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1a000000),
                    offset: Offset(5, 5),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
        Transform.translate(
          offset: Offset(191.0, 16.0),
          child:
              // Adobe XD layer: 'End Session' (group)
              Stack(
            children: <Widget>[
              // Adobe XD layer: 'Modal BG' (group)
              Stack(
                children: <Widget>[
                  // Adobe XD layer: 'Rectangle 1' (shape)
                  Container(
                    width: 143.0,
                    height: 59.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xfff27d7d),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xcbf4f4f4),
                          offset: Offset(-5, -5),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 143.0,
                    height: 59.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xfff27d7d),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1a000000),
                          offset: Offset(5, 5),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'End Dubs',
                        style: primaryPBold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(15.0, 16.0),
          child:
              // Adobe XD layer: 'Timer' (group)
              Stack(
            children: <Widget>[
              // Adobe XD layer: 'Modal BG' (group)
              Stack(
                children: <Widget>[
                  // Adobe XD layer: 'Rectangle 1' (shape)
                  Container(
                    width: 143.0,
                    height: 59.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xcbf4f4f4),
                          offset: Offset(-5, -5),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 143.0,
                    height: 59.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1a000000),
                          offset: Offset(5, 5),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '0 min',
                        style: darkprimaryPBold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
