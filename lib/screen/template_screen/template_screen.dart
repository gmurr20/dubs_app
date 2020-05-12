import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';

class MyNewWidget extends StatefulWidget {
  // add any state here

  MyNewWidget({Key key}) : super(key: key);

  @override
  State<MyNewWidget> createState() => _MyNewWidgetState();
}

class _MyNewWidgetState extends State<MyNewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [Text("Title 1"), Text("Title 2")])));
  }
}
