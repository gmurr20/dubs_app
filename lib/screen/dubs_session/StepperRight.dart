import 'package:flutter/material.dart';

class StepperRight extends StatelessWidget {
  StepperRight({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipOval(
            child: Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: Colors.greenAccent,
                  child: Icon(
                    Icons.expand_less,
                    color: Colors.black,
                    size: 36,
                  ),
                  onTap: () {},
                )),
          ),
          ClipOval(
            child: Material(
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.redAccent,
                child: Icon(
                  Icons.expand_more,
                  color: Colors.black,
                  size: 36,
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
