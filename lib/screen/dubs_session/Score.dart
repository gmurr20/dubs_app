import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  Score({
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
              height: 236.0,
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
              height: 236.0,
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
          offset: Offset(244.0, 69.0),
          child: Text(
            '0',
            style: TextStyle(
              fontFamily: 'Arial Black',
              fontSize: 70,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Transform.translate(
          offset: Offset(58.0, 69.0),
          child: Text(
            '0',
            style: TextStyle(
              fontFamily: 'Arial Black',
              fontSize: 70,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Transform.translate(
          offset: Offset(163.0, 69.0),
          child: Text(
            '-',
            style: TextStyle(
              fontFamily: 'Arial Black',
              fontSize: 70,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
