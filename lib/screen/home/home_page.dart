import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';

class HomePage extends StatefulWidget {
  // add any state here

  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          body: Stack(
            children: [
              Column(
                children: [
                  //Header Modal
                  Container(
                    height: 80.0,
                    margin: EdgeInsets.only(top: 40, left: 12, right: 12),
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
                    child: Stack(children: [
                      Container(
                        padding:
                            spacer.left.md + spacer.top.xs + spacer.bottom.xs,
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
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: spacer.top.xxs,
                          margin: spacer.left.none,
                          child: Text(
                            "Home",
                            style: darkprimaryH1Bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: spacer.top.xs + spacer.bottom.xs,
                        margin: spacer.right.md,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('New Message', style: primaryPBold),
                          color: DarwinRed,
                          onPressed: () {},
                        ),
                      ),
                    ]),
                  ),
                  // Modal containing login form
                  Container(
                    height: 350.0,
                    margin: EdgeInsets.only(top: 10, left: 12, right: 12),
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
                    child: Container(
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
                  ),
                ],
              ),
            ],
          )),
    ]);
  }
}
