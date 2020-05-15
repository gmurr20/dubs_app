import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class XD_MenuButton extends StatelessWidget {
  XD_MenuButton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
        Transform.translate(
          offset: Offset(28.0, 28.0),
          child:
              // Adobe XD layer: 'menu-24px' (group)
              SvgPicture.string(
            _shapeSVG_b12404f3496241618b1949d637fc04a1,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ],
    );
  }
}

const String _shapeSVG_b12404f3496241618b1949d637fc04a1 =
    '<svg viewBox="28.0 28.0 24.0 24.0" ><g transform="translate(28.0, 28.0)"><path  d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 3 18 L 21 18 L 21 16 L 3 16 L 3 18 Z M 3 13 L 21 13 L 21 11 L 3 11 L 3 13 Z M 3 6 L 3 8 L 21 8 L 21 6 L 3 6 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';
